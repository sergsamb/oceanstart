import 'package:jsph_repository/jsph_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';


part 'event.dart';
part 'state.dart';


class
PhotoGetBloc extends Bloc<PhotoGetEvent, PhotoGetState> {
   final int albumId;
   final DataRepository repository;


   PhotoGetBloc({@required this.albumId, @required this.repository}) :
      assert(albumId != null)
      , assert(repository != null)
      , super(
         new PhotoGetInitial()
      );


   @override
   Stream<PhotoGetState>
   mapEventToState(PhotoGetEvent event) async* {
      yield new PhotoGetInProgress();
      if (event is PhotoGet) {
         yield await photoGet(event);
      }
   }


   Future<PhotoGetState>
   photoGet(PhotoGet event) async {
      final resp_ = await repository.fetchPhoto(albumId: albumId);
      final r_ = <PhotoModel> [];
      for (final item in resp_) {
         r_.add(
            new PhotoModel.fromJson(item)
         );
      }

      return new PhotoGetSuccess(photos: r_);
   }
}
