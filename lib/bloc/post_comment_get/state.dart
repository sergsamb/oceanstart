part of 'bloc.dart';


class
PostCommentGetState extends Equatable {
   const
   PostCommentGetState();


   @override
   List<Object>
   get props => [];
}


class
PostCommentGetInitial extends PostCommentGetState {}


class
PostCommentGetInProgress extends PostCommentGetState {}


class
PostCommentGetFailure extends PostCommentGetState {
   final error;


   const
   PostCommentGetFailure(this.error) :
      assert(error != null);


   @override
   List<Object>
   get props => [error, ];
}


class
PostCommentGetSuccess extends PostCommentGetState {
   final List<CommentModel> comments;


   const
   PostCommentGetSuccess({@required this.comments}) :
      assert(comments != null);


   @override
   List<Object>
   get props => [comments, ];
}
