import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceanstart/bloc/bloc.dart';
import 'package:oceanstart/models/models.dart';
import 'package:oceanstart/pages/user_profile/user_profile.dart';
import 'package:oceanstart/theme/theme.dart';
import 'package:oceanstart/widgets/widgets.dart';


class
UsersPage extends StatelessWidget {
   UsersPage({Key key}):
      super(key: key);


   @override
   Widget
   build(BuildContext context) {
      return new Scaffold(
         appBar: new ApplicationBar(titleText: 'Users')
         , body: _buildBody()
      );
   }


   Widget
   _buildBody() {
      return new BlocBuilder<UsersBloc, UsersState>(
         buildWhen: (prev, curr) =>
            (curr != prev)
            && !(
               (prev is UsersGetSuccess) && (curr is UsersInProgress)
            )
            , builder: (ctx, state) {
               if (state is UsersInitial) {
                  return new Container();
               } else if (state is UsersFailure) {
                  return new Center(
                     child: new Text(state.error)
                  );
               } else if (state is UsersInProgress) {
                  return new Center(
                     child: new CircularProgressIndicator()
                  );
               }

               final state_ = state as UsersGetSuccess;

               return _buildContent(state_.users);
            }
      );
   }


   Widget
   _buildContent(List<UserModel> users) {
      return new ListView.separated(
         padding: EdgeInsets.all(Defaults.indent)
         , separatorBuilder: (ctx, index) =>
            new SizedBox(height: Defaults.indent/2)
         , itemBuilder: (ctx, index) =>
            new GestureDetector(
               child: new TitledCart(
                  title: users[index].userName
                  , body: new Text(
                     users[index].name
                     , style: PTextStyle.cardText
                  )
               )
               , onTap: () {
                  Navigator
                     .of(ctx, rootNavigator: true)
                     .push(
                        UserProfilePage.route(user: users[index])
                     );
               }
            )
         , itemCount: users.length
         , shrinkWrap: true
      );
   }
}
