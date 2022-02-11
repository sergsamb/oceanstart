part of 'bloc.dart';


abstract class
UserPostGetState extends Equatable {
   const
   UserPostGetState();


   @override
   List<Object>
   get props => [];
}


class
UserPostGetInitial extends UserPostGetState {}


class
UserPostGetInProgress extends UserPostGetState {}


class
UserPostGetFailure extends UserPostGetState {
   final error;


   const
   UserPostGetFailure(this.error) :
      assert(error != null);


   @override
   List<Object>
   get props => [error, ];
}


class
UserPostGetSuccess extends UserPostGetState {
   final List<PostModel> posts;


   const
   UserPostGetSuccess({@required this.posts}) :
      assert(posts != null);


   @override
   List<Object>
   get props => [posts, ];
}
