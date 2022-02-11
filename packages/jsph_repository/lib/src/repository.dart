import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as _http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


class
DataRepository {
   Future<List<Map<String, dynamic>>>
   fetchUser() async {
      final cache_ = await _fetchFromCache('users');
      if (cache_.isNotEmpty) {
         return cache_;
      }
      return _cachableFetchFromRemote('/users', 'users');
   }


   Future<List<Map<String, dynamic>>>
   fetchPost({@required int userId}) async {
      assert(userId != null);
      final cache_ = await _fetchFromCache('posts_$userId');
      if (cache_.isNotEmpty) {
         return cache_;
      }

      return _cachableFetchFromRemote('/posts?userId=$userId', 'posts_$userId');
   }


   Future<List<Map<String, dynamic>>>
   fetchComment({@required int postId}) async {
      assert(postId != null);
      final cache_ = await _fetchFromCache('comments_$postId');
      if (cache_.isNotEmpty) {
         return cache_;
      }

      return _cachableFetchFromRemote(
         '/comments?postId=$postId', 'comments_$postId'
      );
   }


   Future<List<Map<String, dynamic>>>
   fetchAlbum({@required int userId}) async {
      assert(userId != null);
      final cache_ = await _fetchFromCache('albums_$userId');
      if (cache_.isNotEmpty) {
         return cache_;
      }

      return _cachableFetchFromRemote('/albums?userId=$userId', 'albums_$userId');
   }


   Future<List<Map<String, dynamic>>>
   fetchPhoto({@required int albumId}) async {
      assert(albumId != null);
      final cache_ = await _fetchFromCache('photo_$albumId');
      if (cache_.isNotEmpty) {
         return cache_;
      }

      return _cachableFetchFromRemote(
         '/photos?albumId=$albumId', 'photo_$albumId'
      );
   }


   Future<int>
   sendCommnet({
      @required int postId
      , @required String name
      , @required String email
      , @required String text
   }) async {
      assert(postId != null);
      assert(name.isNotEmpty == true);
      assert(email.isNotEmpty == true);
      assert(text.isNotEmpty == true);

      final newComment_ = {
         'postId': postId
         , 'name': name
         , 'email': email
         , 'body': text
      };
      final r_ = await _http.post(
         Uri.parse('$_baseUri/comments')
         , body: jsonEncode(newComment_)
         , headers: <String, String> {
            'Content-type': 'application/json; charset=UTF-8'
         }
      );

      if (r_.statusCode == 201) {
         newComment_['id'] = Random().nextInt(100);
         final cache_ = await SharedPreferences.getInstance();
         final content_ = List<Map<String, dynamic>>.from(
            jsonDecode(
               cache_.getString('comments_$postId')
            )
         )..insert(0, newComment_);
         cache_.setString(
            'comments_$postId', jsonEncode(content_)
         );
         return newComment_['id'];
      }

      return 0;
   }


   Future<List<Map<String, dynamic>>>
   _fetchFromCache(String key) async {
      final cache_ = await SharedPreferences.getInstance();
      if (cache_.containsKey(key)) {
         return List<Map<String, dynamic>>.from(
            jsonDecode(cache_.getString(key))
         );
      }

      return [];
   }


   Future<List<Map<String, dynamic>>>
   _cachableFetchFromRemote(String path, String key) async {
      final r_ = await _http.get(
         Uri.parse('$_baseUri$path')
      );
      final content_ = r_.body;
      final cache_ = await SharedPreferences.getInstance();
      cache_.setString(key, content_);

      return List<Map<String, dynamic>>.from(
         jsonDecode(content_)
      );
   }


   final _baseUri = 'https://jsonplaceholder.typicode.com';
}
