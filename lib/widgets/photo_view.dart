import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class
PhotoSlider {
   static
   void
   open(
      BuildContext context
      , {@required PhotoGetBloc photoProvider, int startIndex=0}
   ) {
      Navigator.push(
         context
         , MaterialPageRoute(
            builder: (ctx) => new BlocProvider.value(
               value: photoProvider
               , child: new _PhotoSlider(startIndex: startIndex)
            )
         )
      );
   }
}


class
_PhotoSlider extends StatefulWidget {
   final int startIndex;


   _PhotoSlider({this.startIndex=0, Key key}) :
      assert(startIndex?.isNegative == false)
      , super(key: key);


   @override
   _PhotoSliderState
   createState() => new _PhotoSliderState();
}


class
_PhotoSliderState extends State<_PhotoSlider> {
   @override
   void
   initState() {
      _FullScreen.enter();
      _currentIndex = widget.startIndex;
      super.initState();
   }


   @override
   void
   dispose() {
      _FullScreen.exit()
         .then((_) { });
      super.dispose();
   }


   void onPageChanged(int index) {
      setState(() {
         _currentIndex = index;
      });
   }


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         body: new BlocBuilder<PhotoGetBloc, PhotoGetState>(
            builder: (ctx, state) {
               if (state is PhotoGetSuccess) {
                  return _buildPhoto(state.photos);
               }

               return new Container();
            }
         )
         //, backgroundColor: Colors.transparent
      );
   }


   Widget
   _buildPhoto(List<PhotoModel> photos) {
      final backgroundDecoration_ = new BoxDecoration(
         color: Colors.black
      );

      return new Container(
         decoration: backgroundDecoration_
         , constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height
         )
         , child: new Stack(
            alignment: Alignment.bottomCenter
            , children: <Widget> [
               PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics()
                  , builder: (ctx, index) =>
                     PhotoViewGalleryPageOptions.customChild(
                        child: new CachedNetworkImage(
                           imageUrl: photos[index].url
                           , imageBuilder: (ctx, provider) =>
                              new Container(
                                 decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                       image: provider
                                       , fit: BoxFit.contain
                                    )
                                 )
                              )
                        )
                        , initialScale: PhotoViewComputedScale.contained
                        , maxScale: PhotoViewComputedScale.covered * 4.1
                        , tightMode: true
                     )
                  , itemCount: photos.length
                  , backgroundDecoration: backgroundDecoration_
                  , onPageChanged: onPageChanged
                  , scrollDirection: Axis.horizontal
               )
               , new Container(
                  padding: const EdgeInsets.all(20.0)
                  , child: new Text(
                     "${_currentIndex + 1} from ${photos.length}"
                     , style: const TextStyle(
                        color: Colors.white
                        , fontSize: 17.0
                        , decoration: null
                     )
                  )
               )
            ]
         )
      );
   }


   int _currentIndex = 0;
}


class _FullScreen {
   static
   Future<void>
   enter() async {
      await SystemChrome.setEnabledSystemUIOverlays([]);
      _isFullScreen = true;
   }


   static
   Future<void>
   exit() async {
      await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      _isFullScreen = false;
   }


   static
   bool
   get isFullScreen => _isFullScreen;


   static var _isFullScreen = false;
}
