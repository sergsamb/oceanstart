part of 'bloc.dart';


abstract class
UsersState extends Equatable {
   const
   UsersState();


   UsersState
   copyWith() => null;


   @override
   List<Object>
   get props => [];
}


class
UsersInitial extends UsersState {}


class
UsersInProgress extends UsersState {}


class
UsersFailure extends UsersState {
   final error;


   const
   UsersFailure(this.error):
      assert(error != null);


   @override
   List<Object>
   get props => [error, ];
}


class
UsersGetSuccess extends UsersState {
   final List<UserModel> users;


   const
   UsersGetSuccess(this.users) :
      assert(users != null);


   @override
   List<Object>
   get props => [users, ];
}
