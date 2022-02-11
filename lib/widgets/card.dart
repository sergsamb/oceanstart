import 'package:flutter/material.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/theme/theme.dart';


class
TitledCart extends StatelessWidget {
   final String title;
   final Widget body;


   TitledCart({@required this.title, @required this.body, Key key}) :
      assert(title != null)
      , assert(body != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Card(
         elevation: 1
         , child: new Padding(
            padding: EdgeInsets.all(Defaults.indent)
            , child: new Column(
               crossAxisAlignment: CrossAxisAlignment.start
               , children: [
                  new Text(
                     title
                     , style: PTextStyle.cardTitle
                  )
                  , new SizedBox(height: Defaults.indent/2)
                  , body
               ]
            )
         )
      );
   }
}


class
PostPreviewCard extends StatelessWidget {
   final PostModel post;


   PostPreviewCard({@required this.post, Key key}) :
      assert(post != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new TitledCart(
         title: post.title
         , body: new Text(
            post.body.split('\n')[0]
            , style: PTextStyle.cardText
            , overflow: TextOverflow.ellipsis
         )
      ); 
   }
}
