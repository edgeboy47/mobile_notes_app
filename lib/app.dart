import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/auth/application/cubit/auth_cubit.dart';
import 'package:mobile_notes_app/auth/data/authenticator.dart';
import 'package:mobile_notes_app/core/router/app_router.gr.dart';
import 'package:mobile_notes_app/notes/application/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/notes/data/data_sources/firestore.dart';
import 'package:mobile_notes_app/notes/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/notes/data/repository/repository_impl.dart';
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
            repository: RepositoryImpl(
              localDataSource: HiveDatabase(
                notesBox: Hive.box('notesBox'),
                tagsBox: Hive.box('tagsBox'),
              ),
              remoteDataSource: FirestoreDataSource(),
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
              context.read<NotesBloc>().add(NotesLoaded());
              appRouter.pushAndPopUntil(
                const HomeRoute(),
                predicate: (_) => false,
              );
            },
            unknown: (state) {
              appRouter.pushAndPopUntil(
                const LoginRoute(),
                predicate: (_) => false,
              );
            },
            unauthenticated: (state) {
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
