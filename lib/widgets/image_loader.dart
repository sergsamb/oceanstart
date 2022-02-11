import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class
ImageLoader extends StatelessWidget {
   final String url;


   ImageLoader({@required this.url, Key key}) :
      assert(url?.isNotEmpty == true)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new CachedNetworkImage(
         imageUrl: url
         , imageBuilder: (ctx, provider) =>
            new Container(
               decoration: new BoxDecoration(
                  image: new DecorationImage(
                     image: provider
                     , fit: BoxFit.cover
                  )
               )
            )
      );
   }
}
