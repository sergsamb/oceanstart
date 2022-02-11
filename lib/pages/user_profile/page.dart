import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/pages/photo_albums/photo_albums.dart';
import 'package:oceanstart/pages/post_detail/post_detail.dart';
import 'package:oceanstart/pages/user_posts/user_posts.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
UserProfilePage extends StatelessWidget {
   final UserModel user;


   UserProfilePage({@required this.user, Key key}) :
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(
            titleText: user.userName
            , onLeadingPressed: (ctx) => Navigator.of(ctx).pop()
         )
         , body: _buildBody(context)
      );
   }


   Widget
   _buildBody(BuildContext context) {
      return new SingleChildScrollView(
         padding: EdgeInsets.all(Defaults.indent)
         , child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start
            , children: [
               new Container(
                  width: double.infinity
                  , child: new _UserCard(user: user)
               )
               , new SizedBox(height: Defaults.indent*2)
               , new _PostPreview(user: user)
               , new SizedBox(height: Defaults.indent*2)
               ,new _AlbumsPreview(user: user)
               , new SizedBox(height: 70)
            ]
         )
      );
   }


   static
   Route
   route({@required UserModel user}) =>
      MaterialPageRoute<void>(
         builder: (ctx) =>
         new MultiBlocProvider(
            providers: [
               new BlocProvider.value(
                  value: BlocProvider.of<UserPostGetBloc>(ctx)
                     ..add(
                        new UserPostGet(userId: user.userId)
                     )
               )
               , new BlocProvider.value(
                  value: BlocProvider.of<AlbumGetBloc>(ctx)
                     ..add(
                        new AlbumGet(userId: user.userId)
                     )
               )
            ]
            , child: new UserProfilePage(user: user)
         )
      );
}


class
_UserCard extends StatelessWidget {
   final UserModel user;


   _UserCard({@required this.user, Key key}) :
      assert(user != null)
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
                  _buildCardField('Name:', user.name)
                  , new SizedBox(height: Defaults.lineSpace*2)
                  , _buildCardField('E-mail:', user.email)
                  , new SizedBox(height: Defaults.lineSpace*2)
                  , _buildCardField('Phone Number:', user.phone)
                  , new SizedBox(height: Defaults.lineSpace*2)
                  , _buildCardField('Website:', user.website)
                  , new SizedBox(height: Defaults.lineSpace*2)
                  , _buildCardField('Company Name:', user.company.name)
                  , new SizedBox(height: Defaults.lineSpace*2)
                  , _buildCardField('Company BS:', user.company.bs)
                  , new SizedBox(height: Defaults.lineSpace)
                  , _buildCatchPhrase()
                  , new SizedBox(height: Defaults.lineSpace*4)
                  , _buildCardField(
                     'Address:'
                     , '${user.address.zipcode}, ${user.address.city},'
                        ' ${user.address.street}, ${user.address.suite}'
                  )
               ]
            )
         )
      );
   }


   Widget
   _buildCatchPhrase() {
      return Padding(
         padding: EdgeInsets.only(left: Defaults.indent*2)
         ,child: new Text(
            user.company.catchPhrase
            , style: new TextStyle(
               fontSize: 16
               , fontWeight: FontWeight.w400
               , fontStyle: FontStyle.italic
               , color: Colors.black
            )
         )
      );
   }


   Widget
   _buildCardField(String label, String value) {
      return  new Column(
         crossAxisAlignment: CrossAxisAlignment.start
         , children: [
            new Text(
               label
               , style: new TextStyle(
                  fontSize: 16
                  , fontWeight: FontWeight.w400
                  , color: Colors.grey
               )
            )
            , new SizedBox(height: Defaults.lineSpace)
            , new Padding(
               padding: EdgeInsets.only(left: Defaults.indent)
               , child: new Text(
                  value
                  , style: new TextStyle(
                     fontSize: 18
                     , fontWeight: FontWeight.w600
                     , color: Colors.black
                  )
               )
            )
         ]
      );
   }
}


class
_AlbumsPreview extends StatelessWidget {
   final UserModel user;


   _AlbumsPreview({@required this.user, Key key}) :
      assert(user != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocBuilder<AlbumGetBloc, AlbumGetState>(
         builder: (ctx, state) {
            if (state is! AlbumGetSuccess) {
               return new SizedBox(
                  height: 150
                  , child: new NotificationBody(text: 'Load Albums...')
               );
            }

            return _buildBody(
               (state as AlbumGetSuccess).albums
            );
         }
      );
   }


   Widget
   _buildBody(List<AlbumModel> albums) {
      return new Column(
         crossAxisAlignment: CrossAxisAlignment.start
         , children: [
            new Padding(
               padding: EdgeInsets.only(left: Defaults.indent)
               , child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                  , children: [
                     new Text(
                        'Albums'
                        , style: PTextStyle.h4
                     )
                     , new ForwardButton(
                        onPressed: (ctx) =>
                           Navigator.of(ctx, rootNavigator: true)
                              .push(
                                 PhotoAlbumsPage.route(user: user)
                              )
                     )
                  ],
               )
            )
            , for (var i=0; i<min(3, albums.length); i++)
               new Padding(
                  padding: EdgeInsets.only(top: Defaults.indent)
                  , child: new AlbumPreview(album: albums[i])
               )
         ]
      );
   }
}


class
_PostPreview extends StatelessWidget {
   final UserModel user;


   _PostPreview({@required this.user, Key key}) :
      assert(user != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocBuilder<UserPostGetBloc, UserPostGetState>(
         builder: (ctx, state) {
            if (state is! UserPostGetSuccess) {
               return new SizedBox(
                  height: 150
                  , child: new NotificationBody(text: 'Loading Posts...')
               );
            }

            return _buildBody(
               (state as UserPostGetSuccess).posts
            );
         }
      );
   }


   Widget
   _buildBody(List<PostModel> posts) {
      return new Column(
         crossAxisAlignment: CrossAxisAlignment.start
         , children: [
            new Padding(
               padding: EdgeInsets.only(left: Defaults.indent)
               , child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                  , children: [
                     new Text(
                        'Posts'
                        , style: PTextStyle.h4
                     )
                     , new ForwardButton(
                        onPressed: (ctx) =>
                           Navigator.of(ctx, rootNavigator: true)
                              .push(
                                 UserPostsPreviewPage.route(user: user)
                              )
                     )
                  ],
               )
            )
            , new SizedBox(height: 16)
            , new ListView.separated(
               separatorBuilder: (_, __) =>
                  new SizedBox(height: Defaults.indent*0.5)
               , itemBuilder: (ctx, index) => new GestureDetector(
                  onTap: () =>
                     Navigator
                        .of(ctx, rootNavigator: true)
                        .push(
                           PostDetailPage.route(post: posts[index])
                        )
                  , child: new PostPreviewCard(post: posts[index])
               )
               , itemCount: 3
               , shrinkWrap: true
               , physics: NeverScrollableScrollPhysics()
            )
         ]
      );
   }
}
