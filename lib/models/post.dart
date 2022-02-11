import 'package:meta/meta.dart';


class
PostModel {
   final int id;
   final int userId;
   final String title;
   final String body;


   factory
   PostModel.fromJson(Map<String, dynamic> v) {
      return new PostModel._(
         id: v['id']
         , userId: v['userId']
         , title: v['title']
         , body: v['body']
      );
   }


   PostModel._({
      @required this.id
      , @required this.userId
      , @required this.title
      , @required this.body
   });
}
