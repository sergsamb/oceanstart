part of 'bloc.dart';


abstract class
AlbumGetState extends Equatable {
   const
   AlbumGetState();


   @override
   List<Object>
   get props => [];
}


class
AlbumGetInitial extends AlbumGetState {}


class
AlbumGetInProgress extends AlbumGetState {}


class
AlbumGetFailure extends AlbumGetState {
   final error;


   AlbumGetFailure(this.error) :
      assert(error != null);


   @override
   List<Object>
   get props => [error, ];
}


class
AlbumGetSuccess extends AlbumGetState {
   final List<AlbumModel> albums;


   const
   AlbumGetSuccess({@required this.albums}) :
      assert(albums != null);


   @override
   List<Object>
   get props => [albums, ];
}
