import 'package:meta/meta.dart';


class
CommentModel {
   final int id;
   final int postId;
   final String name;
   final String email;
   final String body;


   factory
   CommentModel.fromJson(Map<String, dynamic> v) {
      return new CommentModel._(
         id: v['id']
         , postId: v['postId']
         , name: v['name']
         , email: v['email']
         , body: v['body']
      );
   }


   CommentModel._({
      @required this.id
      , @required this.postId
      , @required this.name
      , @required this.email
      , @required this.body
   });
}
