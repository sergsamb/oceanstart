import 'package:meta/meta.dart';


class
PhotoModel {
   final int id;
   final int albumId;
   final String title;
   final String thumbUrl;
   final String url;


   factory
   PhotoModel.fromJson(Map<String, dynamic> v) {
      return new PhotoModel._(
         id: v['id']
         , albumId: v['albumId']
         , title: v['title']
         , thumbUrl: v['thumbnailUrl']
         , url: v['url']
      );
   }


   const
   PhotoModel._({
      @required this.id
      , @required this.albumId
      , @required this.title
      , @required this.thumbUrl
      , @required this.url
   });
}
