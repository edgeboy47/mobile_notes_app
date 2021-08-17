import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/auth/application/cubit/auth_cubit.dart';
import 'package:mobile_notes_app/core/router/app_router.gr.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const EmailSignInRoute());
                },
                child: const Text('Continue With Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().signInWithGoogle();
                },
                child: const Text('Continue With Google'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
