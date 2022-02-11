part of 'bloc.dart';


abstract class
AlbumGetEvent extends Equatable {
   const
   AlbumGetEvent();


   @override
   List<Object>
   get props => [];
}


class
AlbumGet extends AlbumGetEvent {
   final int userId;


   const
   AlbumGet({@required this.userId}) :
      assert(userId != null);


   @override
   List<Object>
   get props => [userId, ];
}
