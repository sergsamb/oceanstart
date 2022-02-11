import 'package:flutter/material.dart';


typedef OnTransitionPressed(BuildContext context);


class
ForwardButton extends StatelessWidget {
   ForwardButton({@required OnTransitionPressed onPressed, Key key}) :
      assert(onPressed != null)
      , _onPressed=onPressed
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new IconButton(
         icon: new Icon(
            Icons.arrow_forward
            , color: Colors.blue
         )
         , iconSize: 24
         , splashRadius: 28
         , onPressed: () => _onPressed(context)
      );
   }


   final OnTransitionPressed _onPressed;
}
