import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/ui/components/main_error_try_again.dart';

import '../../../utils/base_state.dart';
import '../login/login_bloc.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = GetIt.I.get<HomeBloc>();
  final loginBloc = GetIt.I.get<LoginBloc>();

  @override
  void initState() {
    bloc.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Users',
          style: TextStyle(
            color: theme.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              loginBloc.logout();
            },
            icon: Icon(
              Icons.logout,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, BaseState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SuccessState) {
            final users = state.data as List<UserEntity>;
            return RefreshIndicator(
              onRefresh: () async {
                bloc.getUsers();
              },
              color: theme.primaryColor,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.primaryColor,
                      child: Text(
                        user.name[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              ),
            );
          }
          if (state is ErrorState) {
            return MainErrorTryAgain(onTryAgain: bloc.getUsers);
          }
          if (state is LoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: theme.primaryColor,
            ));
          }
          return const Center(child: Text('No users'));
        },
      ),
    );
  }
}
