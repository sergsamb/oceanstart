part of 'bloc.dart';


enum
CommentSendValidationError {
   empty, invalid,
}


class
CommentSendFieldName extends FormzInput<String, CommentSendValidationError> {
   const
   CommentSendFieldName.pure() :
      super.pure('');


   const
   CommentSendFieldName.dirty([String v='']) :
      super.dirty(v);


   @override
   CommentSendValidationError
   validator(String value) {
      if (value.isEmpty) {
         return CommentSendValidationError.empty;
      } else if (!_regExp.hasMatch(value)) {
         return CommentSendValidationError.invalid;

      }

      return null;
   }


   static
   RegExp _regExp = new RegExp(r'^[a-zA-Z ]*$');
}


class
CommentSendFieldEmail extends FormzInput<String, CommentSendValidationError> {
   const
   CommentSendFieldEmail.pure() :
      super.pure('');


   const
   CommentSendFieldEmail.dirty([String v='']) :
      super.dirty(v);


   @override
   CommentSendValidationError
   validator(String value) {
      if (value.isEmpty) {
         return CommentSendValidationError.empty;
      } else if (!_regExp.hasMatch(value)) {
         return CommentSendValidationError.invalid;
      }

      return null;
   }


   static
   RegExp _regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@'
      r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
      r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
   );
}


class
CommentSendFieldComment extends FormzInput<String, CommentSendValidationError> {
   const
   CommentSendFieldComment.pure() :
      super.pure('');


   const
   CommentSendFieldComment.dirty([String v='']) :
      super.dirty(v);


   @override
   CommentSendValidationError
   validator(String value) =>
      value.isNotEmpty ? null : CommentSendValidationError.empty;
}


class
PostCommentSendState extends Equatable {
   final FormzStatus status;
   final CommentSendFieldName name;
   final CommentSendFieldEmail email;
   final CommentSendFieldComment comment;

   
   PostCommentSendState({
      this.status=FormzStatus.pure
      , this.name=const CommentSendFieldName.pure()
      , this.email=const CommentSendFieldEmail.pure()
      , this.comment=const CommentSendFieldComment.pure()
   });


   PostCommentSendState
   copyWith({
      FormzStatus status
      , CommentSendFieldName name
      , CommentSendFieldEmail email
      , CommentSendFieldComment comment
   }) => new PostCommentSendState(
      status: status ?? this.status
      , name: name ?? this.name
      , email: email ?? this.email
      , comment: comment ?? this.comment
   );


   @override
   List<Object>
   get props => [status, name, email, comment, ];
}
