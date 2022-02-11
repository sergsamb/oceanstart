part of 'bloc.dart';


class
PostCommentGetEvent extends Equatable {
   const
   PostCommentGetEvent();


   @override
   List<Object>
   get props => [];
}


class
PostCommentGet extends PostCommentGetEvent {
   final int userId;
   final int postId;


   const
   PostCommentGet({@required this.userId, @required this.postId}) :
      assert(userId != null)
      , assert(postId != null);


   @override
   List<Object>
   get props => [userId, postId, ];
}
