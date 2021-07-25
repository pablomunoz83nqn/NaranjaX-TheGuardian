// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

NewsResponse newsResponseFromJson(String str) => NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
    String status;
    int total;
    List<Results> results;

    NewsResponse({
        this.status,
        this.total,
        this.results,
    });

    factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        total: json["total"],
        results: List<Results>.from(json["response"]["results"].map((x) => Results.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Results {
   
    String author;
    String webTitle;
    String description;
    String apiUrl;
    String webUrl;
    DateTime webPublicationDate;
    String content;

    Results({
        
        this.author,
        this.webTitle,
        this.description,
        this.apiUrl,
        this.webUrl,
        this.webPublicationDate,
        this.content,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
       
        author: json["author"] == null ? null : json["author"],
        webTitle: json["webTitle"],
        description: json["description"],
        apiUrl: json["apiUrl"],
        webUrl: json["webUrl"],
        webPublicationDate: DateTime.parse(json["webPublicationDate"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        
        "author": author == null ? null : author,
        "webTitle": webTitle,
        "description": description,
        "apiUrl": apiUrl,
        "webUrl": webUrl,
        "publishedAt": webPublicationDate.toIso8601String(),
        "content": content,
    };
}


