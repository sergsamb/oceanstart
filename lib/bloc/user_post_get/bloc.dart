import 'package:bloc/bloc.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:oceanstart/models/models.dart';

part 'event.dart';
part 'state.dart';


class
UserPostGetBloc extends Bloc<UserPostGetEvent, UserPostGetState> {
   final DataRepository repository;


   UserPostGetBloc({@required this.repository}) :
      assert(repository != null)
      , super(
         new UserPostGetInitial()
      );


   @override
   Stream<UserPostGetState>
   mapEventToState(UserPostGetEvent event) async* {
      yield new UserPostGetInProgress();
      if (event is UserPostGet) {
         yield await userPostGet(event);
      }
   }


   Future<UserPostGetState>
   userPostGet(UserPostGet event) async {
      final resp_ = await repository.fetchPost(userId: event.userId);
      final r_ = <PostModel> [];
      for (final item in resp_) {
         r_.add(
            new PostModel.fromJson(item)
         );
      }

      return new UserPostGetSuccess(posts: r_);
   }
}
