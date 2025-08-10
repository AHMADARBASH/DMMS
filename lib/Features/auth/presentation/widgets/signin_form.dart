import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/custom_dialog.dart';
import 'package:dmms/Core/presentation/widgets/loading_widget.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/auth/bloc/auth_bloc.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: AppSize.s10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: userNameController,
            action: TextInputAction.next,
            lable: AppStrings.userName.tr(),
            hint: '',
            icon: Icons.person,
            hasSuffix: false,
            validator: (value) {
              if (value == null || value == '') {
                return AppStrings.pleaseEnterTheUsername.tr();
              } else {
                return null;
              }
            },
          ),
          CustomTextField(
            controller: passwordController,
            hint: '',
            lable: AppStrings.password.tr(),
            icon: Icons.lock,
            action: TextInputAction.done,
            isPassword: true,
            hasSuffix: true,
            validator: (value) {
              if (value == null || value == '') {
                return AppStrings.pleaseEnterThePassword.tr();
              } else if (value.length < 8) {
                return AppStrings.passwordMustBeAtLeast8Charachters.tr();
              } else {
                return null;
              }
            },
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state) {
                case Error():
                  showCustomDialog(
                      context: context,
                      title: state.errorResponse.errorMessage,
                      content: state.errorResponse.details,
                      onPressed: () {
                        context.pop();
                      });
              }
            },
            builder: (context, state) {
              bool isLoading = switch (state) { Loading() => true, _ => false };
              return InkWell(
                onTap: () async {
                  if (isLoading) {
                    return;
                  }
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  context.read<AuthBloc>().add(AuthEvent.login({
                        "username": userNameController.text,
                        "password": passwordController.text,
                      }));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    color: context.appColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  child: switch (state) {
                    Loading() => const LoadingWidget(),
                    _ => Text(
                        AppStrings.login.tr(),
                        style: TextStyle(
                          color: context.appColors.surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
