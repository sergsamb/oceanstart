import 'package:flutter/material.dart';


typedef void OnAppBarLeadingPressed(BuildContext context);


class
ApplicationBar extends AppBar {
   ApplicationBar({
      @required String titleText
      , OnAppBarLeadingPressed onLeadingPressed
      , Key key
   }) :
      assert(titleText != null)
      , super(
         title: new Text(titleText)
         , leading: onLeadingPressed != null
            ? new Builder(
               builder: (ctx) => new IconButton(
                  icon: new Icon(Icons.arrow_back_outlined)
                  , onPressed: () => onLeadingPressed(ctx)
               )
            )
            : null
      );
}
