import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/pages/post_comment_send/post_comment_send.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
PostDetailPage extends StatelessWidget {
   final PostModel post;


   PostDetailPage({@required this.post, Key key}) :
      assert(post != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(
            titleText: '${post.title}'
            , onLeadingPressed: (ctx) => Navigator.of(ctx).pop()
         )
         , body: _buildBody()
         , floatingActionButton: _buildcommentButton(context)
         , floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
      );
   }


   static
   Route
   route({@required PostModel post}) =>
      new MaterialPageRoute<void>(
         builder: (ctx) =>
            new BlocProvider(
               create: (ctx) => new PostCommentGetBloc(
                  repository: RepositoryProvider.of<DataRepository>(ctx)
               )
                  ..add(
                     new PostCommentGet(userId: post.userId, postId: post.id)
                  )
               , child: new PostDetailPage(post: post)
            )
      );


   Widget
   _buildcommentButton(BuildContext context) {
      return FloatingActionButton.extended(
         label: new Text('Comment')
         , onPressed: () async {
            bool isSendOk_ =
               await Navigator.of(context, rootNavigator: true)
                  .push(
                     PostCommentSendPage.route(post: post)
                  );
            if (isSendOk_ ?? false) {
               BlocProvider.of<PostCommentGetBloc>(context)
                  ..add(
                     new PostCommentGet(userId: post.userId, postId: post.id)
                  );
            }
         }
      );
   }


   Widget
   _buildBody() {
      return new SingleChildScrollView(
         padding: EdgeInsets.fromLTRB(
            Defaults.indent
            , Defaults.indent*2
            , Defaults.indent
            , Defaults.indent
         )
         , child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start
            , children: [
               new Text(
                  post.body
                  , style: new TextStyle(
                     fontSize: 20
                     , fontWeight: FontWeight.w400
                     , color: Colors.black
                  )
               )
               , new SizedBox(height: Defaults.indent*3)
               , new Padding(
                  padding: EdgeInsets.only(left: Defaults.indent)
                  ,child: new Text(
                     'Comments', style: PTextStyle.h4
                  )
               )
               , _CommentView()
            ]
         )
      );
   }
}


class
_CommentView extends StatelessWidget {
   _CommentView({Key key}) :
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocBuilder<PostCommentGetBloc, PostCommentGetState>(
         builder: (ctx, state) {
            if (state is PostCommentGetFailure) {
               return new Padding(
                  padding: EdgeInsets.only(top: Defaults.indent*2)
                  , child: new NotificationBody(text: 'Ooops...')
               );
            } else if (state is PostCommentGetSuccess) {
               if (state.comments.length > 0) {
                  return _buildCommentBody(ctx, state.comments);
               }

               return new Padding(
                  padding: EdgeInsets.only(top: Defaults.indent*2)
                  , child: new NotificationBody(text: 'No Comments')
               );
            }

            return new Padding(
               padding: EdgeInsets.only(top: Defaults.indent*2)
               , child: new SizedBox(
                  height: 50
                  , child: new NotificationBody(text: 'Loading Commnets...')
               )
            );
         }
      );
   }


   Widget
   _buildCommentBody(BuildContext context, List<CommentModel> posts) {
      return new Column(
         crossAxisAlignment: CrossAxisAlignment.start
         , children: [
            for (var post in posts)
               _buildComment(post)
            , new SizedBox(height: 70)
         ]
      );
   }


   Widget
   _buildComment(CommentModel comment) {
      return new Padding(
         padding: EdgeInsets.only(top: Defaults.indent)
         , child: new _CommentCard(comment: comment)
      );
   }
}


class
_CommentCard extends StatelessWidget {
   final CommentModel comment;


   _CommentCard({@required this.comment, Key key}) :
      assert(comment != null)
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
                     comment.name
                     , style: PTextStyle.cardTitle
                  )
                  , new SizedBox(height: Defaults.lineSpace*0.7)
                  , new Text(
                     comment.email
                     , style: PTextStyle.cardText.copyWith(fontSize: 14)
                  )
                  , new SizedBox(height: Defaults.indent)
                  , new Text(
                     comment.body
                     , style: PTextStyle.cardText.copyWith(color: Colors.black)
                  )
               ]
            )
         )
      );
   }
}
