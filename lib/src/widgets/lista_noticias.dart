import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/news_models.dart';



class ListaNoticias extends StatelessWidget {

  final List<Results> noticias;

  const ListaNoticias( this.noticias );


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {


        return _Noticia( noticia: this.noticias[index], index: index );
     }
    );
  }
}


class _Noticia extends StatelessWidget {

  final Results noticia;
  final int index;

  const _Noticia({ 
    @required this.noticia, 
    @required this.index 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar( noticia, index ),

        _TarjetaTitulo( noticia ),

        _TarjetaImagen( noticia ),

        _TarjetaBody( noticia ),


        _TarjetaBotones(),

        SizedBox( height: 10 ),
        Divider(),
        

      ],
    );
  }
}


class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: Icon( Icons.star_border ),
          ),

          SizedBox( width: 10 ),

          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: Icon( Icons.more ),
          ),


        ],
      ),
    );
  }
}


class _TarjetaBody extends StatelessWidget {
  
  final Results noticia;

  const _TarjetaBody( this.noticia );



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text( (noticia.description != null) ? noticia.description : '')
    );
  }
}



class _TarjetaImagen extends StatelessWidget {
  
  final Results noticia;

  const _TarjetaImagen( this.noticia );


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( vertical: 10 ),
      child: ClipRRect(
        borderRadius: BorderRadius.only( topLeft: Radius.circular(50), bottomRight: Radius.circular(50) ),
        child: Container(
          child: ( noticia.webUrl != null ) 
              ? FadeInImage(
                  placeholder: AssetImage( 'assets/img/giphy.gif' ), 
                  image: NetworkImage( 'https://source.unsplash.com/random/300x200?sig=incrementingIdentifier' )
                )
              : Image( image: AssetImage('assets/img/no-image.png'), )
        ),
      ),
    );
  }
}



class _TarjetaTitulo extends StatelessWidget {

  final Results noticia;

  const _TarjetaTitulo( this.noticia );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 15 ),
      child: GestureDetector(
        onTap: _launchURL,
        child: 
        Text( noticia.webTitle, style: TextStyle( fontSize: 18, fontWeight: FontWeight.w700 ),
         )
         ),
    );
  }

  _launchURL() async {
  String url = noticia.webUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  
}






class _TarjetaTopBar extends StatelessWidget {

  final Results noticia;
  final int index;

  const _TarjetaTopBar( this.noticia, this.index );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10),
      margin: EdgeInsets.only( bottom: 10 ),
      child: Row(
        children: <Widget>[
          Text('${ index + 1 }. ', style: TextStyle( color: miTema.accentColor ),),
          
        ],
      ),

    );
  }
}