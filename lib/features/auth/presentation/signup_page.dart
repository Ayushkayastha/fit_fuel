
import 'package:fit_fuel/config/extensions/context_extension.dart';
import 'package:fit_fuel/config/extensions/text_theme_extention.dart';
import 'package:fit_fuel/config/route/paths.dart';
import 'package:fit_fuel/features/auth/presentation/provider/checkbox_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_assets/app_assets.dart';
import '../../../shared/components/custom_bottom_btn.dart';
import '../data/models/register_request_model.dart';
import '../data/repository/auth_repository_impl.dart';
import '../domain/usecases/register_user_usecase.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  TextEditingController _nameController=TextEditingController();
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
    final isboxChecked=ref.watch(checkboxProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            context.go(Paths.loginPageRoute.path);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                'Join App name Today',
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: context.textTheme.titleMedium,
                  ),

                ],
              ),
              SizedBox(height: 4.h,),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon:Icon(Icons.person) ,
                  hintText: 'Enter Name',
                ),
              ),
              SizedBox(height: 16.h,),
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
                mainAxisAlignment: MainAxisAlignment.start,
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
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 32.h),
                child: Row(
                  children: [
                    Checkbox(
                        value: isboxChecked,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        onChanged:(value){
                          ref.read(checkboxProvider.notifier).state=value!;
                        }
                    ),
                    Text(
                      'I agree to app Name',
                      style: context.textTheme.bodyLarge,
                    ),

                    InkWell(
                        onTap: (){},
                        child: Text('Terms & Condition',style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colorScheme.secondaryContainer,
                        ),)
                    ),
                  ],
                ),
              ),


              Padding(
                padding:  EdgeInsets.symmetric(vertical: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: context.textTheme.titleMedium,
                    ),

                    InkWell(

                        onTap: (){
                          context.go(Paths.loginPageRoute.path);
                          },
                        child: Text('Sign in',style: context.textTheme.titleMediumEmphasized.copyWith(
                          color: context.colorScheme.secondaryContainer,
                        ),)
                    ),
                  ],
                ),
              ),

              CustomBottomBtn(
                  context: context,
                  name:'Sign Up',
                  callBack: () async {
                    final useCase = RegisterUserUseCase(AuthRepositoryImpl());

                    try {
                      final result = await useCase(RegisterRequestModel(
                        name: _nameController.text.trim(),
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
                      context.go(Paths.loginPageRoute.path);
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('❌ Registration failed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      context.go(Paths.signupPageRoute.path);
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
