import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../Core/extensions/context_extenstions.dart';
import '../../../../Core/presentation/widgets/add_button_widget.dart';
import '../../../../Core/presentation/widgets/back_button_widget.dart';
import '../../../../Core/presentation/widgets/custom_dialog.dart';
import '../../../../Core/presentation/widgets/show_snack_bar.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../bloc/users_bloc.dart';
import '../widgets/user_widget.dart';
import 'add_user_page.dart';

class UsersPage extends StatefulWidget {
  static const routeName = '/UsersPage';
  final String userRole;
  const UsersPage({super.key, required this.userRole});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    context.read<UsersBloc>().add(UsersEvent.getAllUsers());
    super.initState();
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.surfaceContainer,
      appBar: AppBar(
        title: CustomTextField(
          controller: searchController,
          hasSuffix: false,
          lable: AppStrings.searchInUsers.tr(),
          action: TextInputAction.search,
          validator: AppValidators.notRequired,
          onChanged: (value) {
            context
                .read<UsersBloc>()
                .add(UsersEvent.search(query: searchController.text));
          },
        ),
        leading: BackButtonWidget(),
        actions: [
          AddButtonWidget(
            onPressed: () {
              context.pushNamed(AddUserPage.routeName);
            },
          ),
        ],
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
          if (state.errorResponse != null) {
            showCustomDialog(
                context: context,
                title: state.errorResponse!.errorMessage,
                content: state.errorResponse!.details,
                onPressed: () {
                  context.pop();
                  context.read<UsersBloc>().add(UsersEvent.resetFlags());
                });
          }
          if (state.userUpdated) {
            showSnackBar(context, AppStrings.userUpdatedSuccessfully.tr());
            context.read<UsersBloc>().add(UsersEvent.resetFlags());
          }
          if (state.passwordReseted) {
            showSnackBar(context, AppStrings.passwordResetedSuccessfully.tr());
            context.read<UsersBloc>().add(UsersEvent.resetFlags());
          }
        },
        builder: (context, state) {
          if (state.errorResponse != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<UsersBloc>().add(UsersEvent.getAllUsers());
                    },
                    icon: Icon(
                      Icons.replay,
                      color: context.appColors.primary,
                    ),
                  )
                ],
              ),
            );
          }
          if (state.users.isNotEmpty) {
            return SizedBox(
              width: context.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                child: RefreshIndicator(
                  color: context.appColors.primary,
                  backgroundColor: context.appColors.surface,
                  onRefresh: () async {
                    context.read<UsersBloc>().add(UsersEvent.getAllUsers());
                  },
                  child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserWidget(
                          user: user,
                          userRole: widget.userRole,
                        );
                      }),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
