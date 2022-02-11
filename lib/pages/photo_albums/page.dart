import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
PhotoAlbumsPage extends StatelessWidget {
   final UserModel user;


   PhotoAlbumsPage({@required this.user, Key key}) :
      assert(user != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(
            titleText: '${user.userName} / Albums'
            , onLeadingPressed: (ctx) => Navigator.of(ctx).pop()
         )
         , body: _buildBody()
      );
   }


   static
   Route
   route({@required UserModel user}) =>
      new MaterialPageRoute<void>(
         builder: (_) => new PhotoAlbumsPage(user: user)
      );


   Widget
   _buildBody() {
      return new BlocBuilder<AlbumGetBloc, AlbumGetState>(
         builder: (ctx, state) {
            if (state is AlbumGetFailure) {
               return new NotificationBody(text: 'Ooops...');
            } else if (state is AlbumGetSuccess) {
               return _buildPreview(ctx, state.albums);
            }

            return new ProgressBody();
         }
      );
   }


   Widget
   _buildPreview(BuildContext context, List<AlbumModel> albums) {
      return new SingleChildScrollView(
         padding: EdgeInsets.symmetric(
            vertical: Defaults.indent*2, horizontal: Defaults.indent
         )
         , child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start
            , children: [
               for (final item in albums)
                  new AlbumPreview(album: item)
            ]
         )
      );
   }
}
