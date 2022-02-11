part of 'bloc.dart';


abstract class
UsersEvent extends Equatable {
   const
   UsersEvent();


   @override
   List<Object>
   get props => [];
}


class
UsersGet extends UsersEvent {
   final List<int> userId;


   UsersGet({List<int> userId}):
      this.userId=userId ?? [];


   @override
   List<Object>
   get props => [userId, ];
}
