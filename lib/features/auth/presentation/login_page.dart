import 'package:fit_fuel/config/extensions/context_extension.dart';
import 'package:fit_fuel/config/extensions/text_theme_extention.dart';
import 'package:fit_fuel/config/route/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_assets/app_assets.dart';
import '../../../shared/components/custom_bottom_btn.dart';
import '../data/models/login_request_model.dart';
import '../data/repository/auth_repository_impl.dart';
import '../domain/usecases/login_user_usecase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 64.h),
             Container(
               height: 100.h,
               width: 100.w,
               decoration: BoxDecoration(
                 color: context.colorScheme.primaryContainer,
                 borderRadius: BorderRadius.circular(100.r),
               ),
             ),
              Text(
                'Let’s Get Started!',
                style: context.textTheme.headlineLargeEmphasized,
              ),
              Text(
                'Lets dive into your account',
                  style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 32.h,),
              Row(
                children: [
                  Text(
                      'Email Address',
                      style: context.textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 4.h,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,size: 16.sp,),
                  hintText: 'Enter Email Adderess',
                ),
              ),
              SizedBox(height: 16.h,),
              Row(
                children: [
                  Text(
                    'Password',
                    style: context.textTheme.titleMedium,
                  ),

                ],
              ),
              SizedBox(height: 4.h,),
              TextFormField(
                controller: _pwdController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    height: 48.h,
                    width: 48.w,
                    child: Center(
                      child: SvgPicture.asset(
                        AuthpageIcons.lock,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ),
                  hintText: 'Enter Password',
                ),
              ),
              SizedBox(height: 20.h,),

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: context.textTheme.titleMedium,
                    ),

                    InkWell(
                        onTap: (){
                          context.go(Paths.signupPageRoute.path);
                        },
                        child: Text('Sign up',style: context.textTheme.titleMediumEmphasized.copyWith(
                          color: context.colorScheme.secondaryContainer,
                        ),)
                    ),
                  ],
                ),
              ),

              CustomBottomBtn(
                  context: context,
                  name:'Sign In',
                  callBack: () async {
                    final useCase = LoginUserUseCase(AuthRepositoryImpl());

                    try {
                      final result = await useCase(LoginRequestModel(
                        email: _emailController.text.trim(),
                        password: _pwdController.text.trim(),
                      ));

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('✅ ${result.message}'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // TODO: Save token to secure storage if needed
                      context.go(Paths.landingPageRoute.path);
                    } catch (e) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('❌ Login failed. Please check your credentials.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
