import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:meta/meta.dart';
import 'package:oceanstart/models/models.dart';

part 'event.dart';
part 'state.dart';


class
UsersBloc extends Bloc<UsersEvent, UsersState> {
   final DataRepository repository;


   UsersBloc({@required this.repository}):
      assert(repository != null)
      , super(
         new UsersInitial()
      );


   @override
   Stream<UsersState>
   mapEventToState(UsersEvent event) async* {
      yield new UsersInProgress();
      if (event is UsersGet) {
         yield await usersGet(event);
      }
   }


   Future<UsersState>
   usersGet(UsersGet event) async {
      final resp_ = await repository.fetchUser();
      final r_ = <UserModel> [];
      for (final item in resp_) {
         r_.add(
            new UserModel.fromJson(item)
         );
      }

      return new UsersGetSuccess(r_);
   }
}
