import 'package:meta/meta.dart';


class
AlbumModel {
   final int id;
   final int userId;
   final String title;


   factory
   AlbumModel.fromJson(Map<String, dynamic> v) {
      return new AlbumModel(
         id: v['id']
         , userId: v['userId']
         , title: v['title']
      );
   }


   AlbumModel({
      @required this.id, @required this.userId, @required this.title
   });
}
