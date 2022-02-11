import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/pages/photo_gallery/photo_gallery.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
AlbumPreview extends StatelessWidget {
   final AlbumModel album;


   AlbumPreview({@required this.album, Key key}) :
      assert(album != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocProvider(
         create: (ctx) =>
            new PhotoGetBloc(
               albumId: album.id
               , repository: RepositoryProvider.of<DataRepository>(ctx)
            )
               ..add(
                  new PhotoGet()
               )
         , child: new BlocBuilder<PhotoGetBloc, PhotoGetState>(
            builder: (ctx, state) {
               if (state is! PhotoGetSuccess) {
                  return new Container();
               }

               return _buildBody(
                  (state as PhotoGetSuccess).photos
               );
            }
         )
      );
   }


   Widget
   _buildBody(List<PhotoModel> photos) {
      return new Column(
         crossAxisAlignment: CrossAxisAlignment.start
         , children: [
            new Text(
               album.title
               , style: PTextStyle.cardTitle
            )
            , new SizedBox(height: Defaults.indent)
            , new GridView.builder(
               gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3
                  , mainAxisSpacing: 1
                  , crossAxisSpacing: 1
               )
               , physics: NeverScrollableScrollPhysics()
               , shrinkWrap: true
               , itemCount: min(6, photos.length)
               , itemBuilder: (ctx, index) =>
                  new GestureDetector(
                     child: new ImageLoader(url: photos[index].url)
                     , onTap: () => PhotoSlider.open(
                        ctx
                        , photoProvider: BlocProvider.of<PhotoGetBloc>(ctx)
                        , startIndex: index
                     )
                  )
            )
            , new SizedBox(height: Defaults.indent*0.5)
            , new Row(
               mainAxisAlignment: MainAxisAlignment.end
               , children: [
                  new Text(
                     'All'
                     , style: new TextStyle(
                        fontSize: 18
                        , fontWeight: FontWeight.w600
                        , color: Colors.blue
                     )
                  )
                  , new ForwardButton(
                     onPressed: (ctx) =>
                        Navigator.of(ctx, rootNavigator: true)
                           .push(
                              PhotoGalleryPage.route(
                                 title: album.title
                                 , photoProvider:
                                    BlocProvider.of<PhotoGetBloc>(ctx)
                              )
                           )
                  )
               ]
            )
         ]
      );
   }
}
