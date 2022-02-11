import 'package:flutter/material.dart';
import 'package:oceanstart/theme/theme.dart';

class
NotificationBody extends StatelessWidget {
   final String text;


   NotificationBody({@required this.text, Key key}) :
      assert(text.isNotEmpty == true)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Center(
         child: new Text(
            text
            , style: PTextStyle.h4.copyWith(color: Colors.grey)
         )
      );
   }
}


class
ProgressBody extends StatelessWidget {
   ProgressBody({Key key}) :
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Center(
         child: new CircularProgressIndicator()
      );
   }
}
