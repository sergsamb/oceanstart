part of 'bloc.dart';


abstract class
PhotoGetState extends Equatable {
   const
   PhotoGetState();


   @override
   List<Object>
   get props => [];
}


class
PhotoGetInitial extends PhotoGetState {}


class
PhotoGetInProgress extends PhotoGetState {}


class
PhotoGetFailure extends PhotoGetState {
   final error;


   const
   PhotoGetFailure(this.error) :
      assert(error != null);


   @override
   List<Object>
   get props => [error, ];
}


class
PhotoGetSuccess extends PhotoGetState {
   final List<PhotoModel> photos;


   const
   PhotoGetSuccess({@required this.photos}) :
      assert(photos != null);


   @override
   List<Object>
   get props => [];
}
