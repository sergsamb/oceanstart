import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
PostCommentSendPage extends StatelessWidget {
   final PostModel post;


   PostCommentSendPage({@required this.post, Key key}) :
      assert(post != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(
            titleText: 'Send Comment'
            , onLeadingPressed: (ctx) => Navigator.of(ctx).pop(false)
         )
         , body: _buildBody(context)
         , floatingActionButton: _buildSendButton()
      );
   }


   static
   Route
   route({@required PostModel post}) =>
      new MaterialPageRoute<bool>(
         builder: (ctx) =>
            new BlocProvider(
               create: (ctx) => new PostCommentSendBloc(
                  postId: post.id
                  , repository: RepositoryProvider.of<DataRepository>(ctx)
               )
               , child: new PostCommentSendPage(post: post)
            )
      );


   Widget
   _buildBody(BuildContext context) {
      return new Padding(
         padding: EdgeInsets.all(Defaults.indent*1.5)
         , child: new BlocListener<PostCommentSendBloc, PostCommentSendState>(
            listener: (ctx, state) {
               if (state.status.isSubmissionSuccess) {
                  Navigator.of(context, rootNavigator: true)
                     .pop(true);
               } else if (state.status.isSubmissionFailure) {
                  Scaffold.of(ctx)
                     ..hideCurrentSnackBar()
                     ..showSnackBar(
                        new SnackBar(
                           content: new Text('Send Comment Failure')
                        )
                     );
               }
            }
            , child: new Column(
               children: [
                  new CommentNameInput()
                  , new SizedBox(height: Defaults.indent*1.5)
                  , new CommentEmailInput()
                  , new SizedBox(height: Defaults.indent*1.5)
                  , new CommentTextInput()
               ]
            )
         )
      );
   }


   Widget
   _buildSendButton() {
      return new BlocBuilder<PostCommentSendBloc, PostCommentSendState>(
         builder: (ctx, state) {
            if (state.status.isValid || state.status.isSubmissionFailure) {
               return FloatingActionButton.extended(
                  label: new Text('Send')
                  , onPressed: () =>
                     BlocProvider.of<PostCommentSendBloc>(ctx)
                        .add(
                           new PostCommentSubmitRequested()
                        )
               );
            } else if (state.status.isSubmissionInProgress) {
               return new CircularProgressIndicator();
            }

            return new SizedBox.shrink();
         }
      );
   }
}


class
CommentNameInput extends StatelessWidget {
   CommentNameInput({Key key}) :
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocBuilder<PostCommentSendBloc, PostCommentSendState>(
         buildWhen: (prev, curr) => prev.name != curr.name
         , builder: (ctx, state) {
            return new TextField(
               key: const Key('Send_Name_Input')
               , onChanged: (name) =>
                  BlocProvider
                     .of<PostCommentSendBloc>(ctx)
                     .add(
                        new PostCommentNameFieldChanged(value: name)
                     )
               , decoration: new InputDecoration(
                  labelText: 'Name'
                  , errorText: state.name.invalid ? 'Так не пойдёт...' : null
               )
            );
         }
      );
   }
}


class
CommentEmailInput extends StatelessWidget {
   CommentEmailInput({Key key}) :
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocBuilder<PostCommentSendBloc, PostCommentSendState>(
         buildWhen: (prev, curr) => prev.email != curr.email
         , builder: (ctx, state) {
            return new TextField(
               key: const Key('Send_Email_Input')
               , onChanged: (mail) =>
                  BlocProvider
                     .of<PostCommentSendBloc>(ctx)
                     .add(
                        new PostCommentEmailFieldChanged(value: mail)
                     )
               , decoration: new InputDecoration(
                  labelText: 'E-mail'
                  , errorText: state.email.invalid ? 'Так не пойдёт...' : null
               )
            );
         }
      );
   }
}


class
CommentTextInput extends StatelessWidget {
   CommentTextInput({Key key}) :
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new BlocBuilder<PostCommentSendBloc, PostCommentSendState>(
         buildWhen: (prev, curr) => prev.comment != curr.comment
         , builder: (ctx, state) {
            return new TextField(
               key: const Key('Send_Text_Input')
               , onChanged: (text) =>
                  BlocProvider
                     .of<PostCommentSendBloc>(ctx)
                     .add(
                        new PostCommentTextFieldChanged(value: text)
                     )
               , decoration: new InputDecoration(
                  labelText: 'Text'
                  , errorText: state.comment.invalid ? 'Так не пойдёт...' : null
               )
               , minLines: 5
               , maxLines: 15
            );
         }
      );
   }
}
