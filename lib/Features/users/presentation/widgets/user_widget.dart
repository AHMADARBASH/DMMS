import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/presentation/widgets/confirmation_dialog.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/grey_holder.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/users/bloc/users_bloc.dart';
import 'package:dmms/Features/users/data/models/user.dart';
import 'package:dmms/Features/users/presentation/pages/edit_user_page.dart';
import 'package:dmms/Features/users/presentation/pages/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class UserWidget extends StatelessWidget {
  UserWidget({
    super.key,
    required this.user,
    required this.userRole,
  });

  final User user;
  final String userRole;
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: ValueKey(user.id),
        padding: EdgeInsets.symmetric(vertical: AppPadding.p5),
        child: Row(
          spacing: AppSize.s10,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(UserDetailsPage.routeName, extra: user);
                },
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${user.firstName} ${user.lastName}',
                        maxLines: 1,
                      )),
                      Icon(
                        Icons.circle,
                        color: user.isActive
                            ? context.activeColor
                            : context.pendingColor,
                        size: AppSize.s15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(EditUserPage.routeName, extra: user);
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Icon(
                  Icons.edit,
                  color: context.appColors.primary,
                ),
              ),
            ),
            if (userRole == RolesStrings.superAdmin) ...[
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Form(
                              key: _formKey,
                              child: SizedBox(
                                height: AppSize.s200,
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p8),
                                  child: Column(
                                    children: [
                                      GreyHolder(),
                                      SizedBox(
                                        height: AppSize.s20,
                                      ),
                                      CustomTextField(
                                        hint: '',
                                        lable: AppStrings.password.tr(),
                                        controller: passwordController,
                                        hasSuffix: false,
                                        isPassword: false,
                                        validator: (value) {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            return null;
                                          }
                                          return AppStrings.passwordRequired
                                              .tr();
                                        },
                                      ),
                                      const SizedBox(height: AppSize.s20),
                                      Row(
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Expanded(
                                            flex: 2,
                                            child: AppButton(
                                              onTap: () {
                                                if (!_formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                context.read<UsersBloc>().add(
                                                      UsersEvent
                                                          .resetUserPassword(
                                                        data: {
                                                          "userId": user.id,
                                                          "password":
                                                              passwordController
                                                                  .text,
                                                        },
                                                      ),
                                                    );
                                                context.pop();
                                              },
                                              text:
                                                  AppStrings.resetPassword.tr(),
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                },
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p10),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  child: Icon(
                    Icons.key,
                    color: context.appColors.primary,
                  ),
                ),
              )
            ],
            GestureDetector(
              onTap: () {
                if (user.isActive) {
                  showConfirmationDialog(
                      context: context,
                      onYesPressed: () {
                        context.pop();
                        context.read<UsersBloc>().add(
                              UsersEvent.deActivateUser(userId: user.id),
                            );
                      },
                      onNoPressed: context.pop,
                      content:
                          '${AppStrings.areYouSureYouWantToDeactivate.tr()} ${user.firstName} ${user.lastName}?');
                } else {
                  context
                      .read<UsersBloc>()
                      .add(UsersEvent.activateUser(userId: user.id));
                }
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: context.appColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Icon(
                  user.isActive ? Icons.block : Icons.check_circle,
                  color: context.appColors.primary,
                  size: AppSize.s22,
                ),
              ),
            ),
          ],
        ));
  }
}
