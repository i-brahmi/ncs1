import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/cubits/user_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Sign up',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'create an account to continue!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First name',
                  border: OutlineInputBorder(), // Default border
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                    ), // Blue border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                      width: 2.0,
                    ), // Blue border when focused
                  ),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last name',
                  border: OutlineInputBorder(), // Default border
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                    ), // Blue border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                      width: 2.0,
                    ), // Blue border when focused
                  ),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(), // Default border
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                    ), // Blue border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                      width: 2.0,
                    ), // Blue border when focused
                  ),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText:
                    true, // This makes the text field obscure (for passwords)
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(), // Default border
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                    ), // Blue border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                      width: 2.0,
                    ), // Blue border when focused
                  ),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,

                obscureText:
                    true, // This makes the text field obscure (for passwords)
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(), // Default border
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                    ), // Blue border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.maincolor,
                      width: 2.0,
                    ), // Blue border when focused
                  ),
                ),
              ),

              SizedBox(height: 20),

              InkWell(
                onTap: () {
                  BlocProvider.of<UserCubit>(context, listen: false).signup(
                    emailController.text,
                    firstNameController.text,
                    lastNameController.text,
                    passwordController.text,
                    confirmPasswordController.text,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppStyle.maincolor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey), // Grey border
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, color: Colors.red),
                    SizedBox(width: 5),
                    Text('Continue with Google'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have an account?'),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: AppStyle.maincolor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
