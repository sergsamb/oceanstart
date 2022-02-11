part of 'bloc.dart';


class
PostCommentSendEvent extends Equatable {
   const
   PostCommentSendEvent();


   @override
   List<Object>
   get props => [];
}


class
PostCommentNameFieldChanged extends PostCommentSendEvent {
   final String value;


   const
   PostCommentNameFieldChanged({@required this.value}) :
      assert(value != null);


   @override
   List<Object>
   get props => [value, ];
}


class
PostCommentEmailFieldChanged extends PostCommentSendEvent {
   final String value;


   const
   PostCommentEmailFieldChanged({@required this.value}) :
      assert(value != null);


   @override
   List<Object>
   get props => [value, ];
}


class
PostCommentTextFieldChanged extends PostCommentSendEvent {
   final String value;


   const
   PostCommentTextFieldChanged({@required this.value}) :
      assert(value != null);


   @override
   List<Object>
   get props => [value, ];
}


class
PostCommentSubmitRequested extends PostCommentSendEvent {}
