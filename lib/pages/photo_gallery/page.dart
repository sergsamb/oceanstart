import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
PhotoGalleryPage extends StatelessWidget {
   final String title;


   PhotoGalleryPage({@required this.title, Key key}) :
      assert(title?.isNotEmpty == true)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(
            titleText: title
            , onLeadingPressed: (ctx) => Navigator.of(ctx).pop()
         )
         , body: _buildBody()
      );
   }


   static
   Route
   route({@required String title, @required PhotoGetBloc photoProvider}) =>
      new MaterialPageRoute<void>(
         builder: (_) =>
            new BlocProvider.value(
               value: photoProvider
               , child: new PhotoGalleryPage(title: title)
            )
      );


   Widget
   _buildBody() {
      return new BlocBuilder<PhotoGetBloc, PhotoGetState>(
         builder: (ctx, state) {
            if (state is PhotoGetFailure) {
               return new NotificationBody(text: 'Ooops...');
            } else if (state is PhotoGetSuccess) {
               return _buildGallery(state.photos);
            }

            return new ProgressBody();
         }
      );
   }


   Widget
   _buildGallery(List<PhotoModel> photos) {
      return new GridView.builder(
         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3
            , mainAxisSpacing: 1
            , crossAxisSpacing: 1
         )
         , itemCount: photos.length
         , itemBuilder: (ctx, index) =>
            new GestureDetector(
               child: new ImageLoader(url: photos[index].url)
               , onTap: () => PhotoSlider.open(
                  ctx
                  , photoProvider: BlocProvider.of<PhotoGetBloc>(ctx)
                  , startIndex: index
               )
            )
      );
   }
}
