import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsph_repository/jsph_repository.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/pages/users/users.dart';

void main() {
   runApp(OceanStartApplication());
}

class
OceanStartApplication extends StatelessWidget {
   OceanStartApplication({Key key}):
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      final repository_ = new DataRepository();

      return new RepositoryProvider.value(
         value: repository_
         , child: new MultiBlocProvider(
            providers: [
               new BlocProvider(
                  create: (_) => new UsersBloc(repository: repository_)
                     ..add(
                        new UsersGet()
                     )
               )
               , new BlocProvider(
                  create: (_) => UserPostGetBloc(repository: repository_)
               )
               , new BlocProvider(
                  create: (_) => new AlbumGetBloc(repository: repository_)
               )
            ]
            , child: new _ApplicationView()
         )
      );

   }
}


class
_ApplicationView extends StatefulWidget {
   _ApplicationView({Key key}):
      super(key: key);


   @override
   _ApplicationViewState
   createState() => new _ApplicationViewState();
}


class
_ApplicationViewState extends State<_ApplicationView> {
   @override
   Widget
   build(BuildContext context) {
      return MaterialApp(
         title: 'OceanStart Demo',
         theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
         ),
         home: new UsersPage()
      );
   }
}
