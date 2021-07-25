import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

import '../models/news_models.dart';


final _URL_NEWS = 'https://content.guardianapis.com/search';
final _APIKEY   = 'fbd63c51-5e29-406c-8b86-31703904bdc9';

class NewsService with ChangeNotifier {

  List<Results> headlines = [];
  String _selectedCategory = 'sports';

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'  ),
    Category( FontAwesomeIcons.tv, 'entertainment'  ),
    Category( FontAwesomeIcons.addressCard, 'general'  ),
    Category( FontAwesomeIcons.headSideVirus, 'health'  ),
    Category( FontAwesomeIcons.vials, 'science'  ),
    Category( FontAwesomeIcons.volleyballBall, 'sports'  ),
    Category( FontAwesomeIcons.memory, 'technology'  ),
  ];

  Map<String, List<Results>> categoryArticles = {};


      
  NewsService() {
    this.getTopHeadlines();

    categories.forEach( (item) {
      this.categoryArticles[item.name] = [];
    });

    this.getArticlesByCategory( this._selectedCategory );
  }

  bool get isLoading => this._isLoading;


  get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory( valor );
    notifyListeners();
  }
  
  List<Results> get getArticulosCategoriaSeleccionada => this.categoryArticles[ this.selectedCategory ];



  getTopHeadlines() async {
    
      final url ='$_URL_NEWS?api-key=$_APIKEY';
      final resp = await http.get(url);

      final newsResponse = newsResponseFromJson( resp.body );

      this.headlines.addAll( newsResponse.results );
      notifyListeners();
  }

  getArticlesByCategory( String category ) async {

      if ( this.categoryArticles[category].length > 0 ) {
        this._isLoading = false;
        notifyListeners();
        return this.categoryArticles[category];
      }

      final url ='$_URL_NEWS?api-key=$_APIKEY';
      final resp = await http.get(url);

      final newsResponse = newsResponseFromJson( resp.body );

      this.categoryArticles[category].addAll( newsResponse.results );

      this._isLoading = false;
      notifyListeners();

  }


}




