import 'package:animate_do/animate_do.dart';
import 'package:dmms/Core/resources/app_durations.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:sizer/sizer.dart';
import '../widgets/signin_form.dart';
import '../../../../Core/presentation/widgets/system_logo_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/AuthPage';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final animationDuration = AppDurations.d600ms;
  final curve = Curves.easeOutQuad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeInLeft(
                duration: animationDuration,
                curve: curve,
                child: const SystemLogoWidget(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: FadeInRight(
                  duration: animationDuration,
                  curve: curve,
                  child: SigninForm(
                    userNameController: userNameController,
                    passwordController: passwordController,
                    formKey: _formKey,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
