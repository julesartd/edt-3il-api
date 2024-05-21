import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/utils/custom_button.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitButton extends StatelessWidget {
  final TextEditingController nameController;

  const SubmitButton({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppLocalizations.of(context)!.loginButton,
      onPressed: () {
        final String name = nameController.text.trim();
        context.read<LoginCubit>().saveLoginDetails(name);
      },
      backgroundColor: CustomTheme.secondaryColor,
      textColor: Colors.white,
    );
  }
}
