import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:meta/meta.dart';
import 'package:oceanstart/models/models.dart';

part 'event.dart';
part 'state.dart';


class
PostCommentGetBloc extends Bloc<PostCommentGetEvent, PostCommentGetState> {
   final DataRepository repository;


   PostCommentGetBloc({@required this.repository}) :
      assert(repository != null)
      , super(
         new PostCommentGetInitial()
      );


   @override
   Stream<PostCommentGetState>
   mapEventToState(PostCommentGetEvent event) async* {
      yield new PostCommentGetInProgress();
      if (event is PostCommentGet) {
         yield await postCommentGet(event);
      }
   }


   Future<PostCommentGetState>
   postCommentGet(PostCommentGet event) async {
      final resp_ = await repository.fetchComment(postId: event.postId);
      final r_ = <CommentModel> [];
      for (final item in resp_) {
         r_.add(
            new CommentModel.fromJson(item)
         );
      }

      return new PostCommentGetSuccess(comments: r_);
   }
}
