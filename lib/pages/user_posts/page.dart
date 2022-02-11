import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/pages/post_detail/post_detail.dart';
import 'package:oceanstart/pages/users/users.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
UserPostsPreviewPage extends StatelessWidget {
   final UserModel user;


   UserPostsPreviewPage({@required this.user, Key key}) :
      assert(user != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(
            titleText: '${user.userName} / Posts'
            , onLeadingPressed: (ctx) => Navigator.of(ctx).pop()
         )
         , body: _buildBody()
      );
   }


   static
   Route
   route({@required UserModel user}) =>
      MaterialPageRoute<void>(
         builder: (ctx) =>
            new UserPostsPreviewPage(user: user)
      );


   Widget
   _buildBody() {
      return new BlocBuilder<UserPostGetBloc, UserPostGetState>(
         builder: (ctx, state) {
            if (state is UserPostGetSuccess) {
               if (state.posts.length > 0) {
                  return new _PostsPreview(posts: state.posts);
               }
               return NotificationBody(text: 'No Posts');
            } else if (state is UserPostGetFailure) {
               return NotificationBody(text: 'Ooops...');
            }

            return new ProgressBody();
         }
      );
   }
}


class
_PostsPreview extends StatelessWidget {
   final List<PostModel> posts;


   _PostsPreview({@required this.posts, Key key}) :
      assert(posts != null)
      , super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new ListView.separated(
         padding: EdgeInsets.fromLTRB(
            Defaults.indent, Defaults.indent, Defaults.indent, 70
         )
         , separatorBuilder: (_, __) =>
            new SizedBox(height: Defaults.indent*0.5)
         , itemBuilder: (ctx, index) => new GestureDetector(
            onTap: () =>
               Navigator.of(ctx, rootNavigator: true)
                  .push(
                     PostDetailPage.route(post: posts[index])
                  )
            , child: new PostPreviewCard(post: posts[index])
         )
         , itemCount: posts.length
         , shrinkWrap: false
      );
   }
}
