part of 'bloc.dart';


abstract class
UserPostGetEvent extends Equatable {
   const
   UserPostGetEvent();


   @override
   List<Object>
   get props => [];
}


class
UserPostGet extends UserPostGetEvent {
   final int userId;
   final List<int> postId;


   const
   UserPostGet({@required this.userId, List<int> postId}) :
      postId=postId ?? const [];


   @override
   List<Object>
   get props => [userId, postId, ];
}
