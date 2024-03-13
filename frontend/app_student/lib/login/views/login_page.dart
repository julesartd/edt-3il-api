import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/login/widgets/form/form_login.dart';
import 'package:app_student/login/widgets/header/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/header/header_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is RedirectToClassSelection) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/classList');
          });
          return Container();
        } else if (state is LoginInitial) {
          return const Scaffold(
            body: Column(
              children: [
                HeaderLogo(),
                HeaderText('Bonjour :)'),
                Expanded(child: FormLogin()),
              ],
            ),
          );
        } else if (state is LoginAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/schedule');
          });
          return Container();
        } else if (state is LoginFieldError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Veuillez remplir tous les champs'),
                backgroundColor: Colors.red,
              ),
            );
          });
          return const Scaffold(
            body: Column(
              children: [
                HeaderLogo(),
                HeaderText('Bonjour :)'),
                Expanded(child: FormLogin()),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
