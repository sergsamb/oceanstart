import 'package:jsph_repository/jsph_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';


part 'event.dart';
part 'state.dart';


class
AlbumGetBloc extends Bloc<AlbumGetEvent, AlbumGetState> {
   final DataRepository repository;


   AlbumGetBloc({@required this.repository}) :
      assert(repository != null)
      , super(
         new AlbumGetInitial()
      );


   @override
   Stream<AlbumGetState>
   mapEventToState(AlbumGetEvent event) async* {
      yield new AlbumGetInProgress();
      if (event is AlbumGet) {
         yield await albumGet(event);
      }
   }


   Future<AlbumGetState>
   albumGet(AlbumGet event) async {
      final resp_ = await repository.fetchAlbum(userId: event.userId);
      final r_ = <AlbumModel> [];
      for (final item in resp_) {
         r_.add(
            new AlbumModel.fromJson(item)
         );
      }

      return new AlbumGetSuccess(albums: r_);
   }
}
