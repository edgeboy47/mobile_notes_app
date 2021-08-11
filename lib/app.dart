import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/auth/application/cubit/auth_cubit.dart';
import 'package:mobile_notes_app/auth/data/authenticator.dart';
import 'package:mobile_notes_app/core/router/app_router.gr.dart';
import 'package:mobile_notes_app/notes/application/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/notes/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/ui/themes.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesBloc(
            repository: HiveDatabase(
              notesBox: Hive.box('notesBox'),
              tagsBox: Hive.box('tagsBox'),
            ),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) {
            final cubit = AuthCubit(Authenticator())..updateAuthState();
            return cubit;
          },
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            authenticated: (state) {
              print('auth');
              appRouter.pushAndPopUntil(
                const HomeRoute(),
                predicate: (_) => false,
              );
            },
            unknown: (state) {
              print('unknown');
              appRouter.pushAndPopUntil(
                const LoginRoute(),
                predicate: (_) => false,
              );
            },
            unauthenticated: (state) {
              print('unauth');
              appRouter.pushAndPopUntil(
                const LoginRoute(),
                predicate: (_) => false,
              );
            },
            orElse: () {},
          );
        },
        child: MaterialApp.router(
          title: 'Mobile Notes',
          themeMode: ThemeMode.dark,
          darkTheme: Themes.darkTheme,
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
        ),
      ),
    );
  }
}
