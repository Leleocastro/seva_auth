import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';

import '../../../utils/base_state.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = GetIt.I.get<HomeBloc>();

  @override
  void initState() {
    bloc.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, BaseState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SuccessState) {
            final users = state.data as List<UserEntity>;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.primaryColor,
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          }
          if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text('No users'));
        },
      ),
    );
  }
}
