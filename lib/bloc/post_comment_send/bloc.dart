import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:meta/meta.dart';
import 'package:formz/formz.dart';


part 'event.dart';
part 'state.dart';


class
PostCommentSendBloc extends Bloc<PostCommentSendEvent, PostCommentSendState> {
   final int postId;
   final DataRepository repository;


   PostCommentSendBloc({@required this.postId, @required this.repository}) :
      assert(postId != null)
      , assert(repository != null)
      , super(
         new PostCommentSendState(status: FormzStatus.pure)
      );


   @override
   Stream<PostCommentSendState>
   mapEventToState(PostCommentSendEvent event) async* {
      if (event is PostCommentNameFieldChanged) {
         yield _postCommentNameFieldChanged(event);
      } else if (event is PostCommentEmailFieldChanged) {
         yield _postCommentEmailFieldChanged(event);
      } else if (event is PostCommentTextFieldChanged) {
         yield _postCommentCommentFieldChanged(event);
      } else if (event is PostCommentSubmitRequested) {
         yield* _postCommnetSubmitRequested(event);
      }
   }


   PostCommentSendState
   _postCommentNameFieldChanged(PostCommentNameFieldChanged event) {
      final field_ = new CommentSendFieldName.dirty(event.value);

      return state.copyWith(
         name: field_
         , status: Formz.validate([
            field_
            , new CommentSendFieldEmail.dirty(state.email.value)
            , new CommentSendFieldComment.dirty(state.comment.value)
         ])
      );
   }


   PostCommentSendState
   _postCommentEmailFieldChanged(PostCommentEmailFieldChanged event) {
      final field_ = new CommentSendFieldEmail.dirty(event.value);

      return state.copyWith(
         email: field_
         , status: Formz.validate([
            field_
            , new CommentSendFieldName.dirty(state.name.value)
            , new CommentSendFieldComment.dirty(state.comment.value)
         ])
      );
   }


   PostCommentSendState
   _postCommentCommentFieldChanged(PostCommentTextFieldChanged event) {
      final field_ = new CommentSendFieldComment.dirty(event.value);

      return state.copyWith(
         comment: field_
         , status: Formz.validate([
            field_
            , new CommentSendFieldName.dirty(state.name.value)
            , new CommentSendFieldEmail.dirty(state.email.value)
         ])
      );
   }


   Stream<PostCommentSendState>
   _postCommnetSubmitRequested(PostCommentSubmitRequested event) async* {
      if (state.status.isValid) {
         yield state.copyWith(status: FormzStatus.submissionInProgress);
         final r_ = await repository.sendCommnet(
            postId: postId
            , name: state.name.value
            , email: state.email.value
            , text: state.comment.value
         );
         if (r_ > 0) {
            yield state.copyWith(status: FormzStatus.submissionSuccess);
         } else {
            yield state.copyWith(status: FormzStatus.submissionFailure);
         }
      }
   }
}
