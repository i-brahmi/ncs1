import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/cubits/user_cubit.dart';
import 'package:ncs/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Sign in to your Account',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppStyle.maincolor),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  BlocProvider.of<UserCubit>(
                    context,
                    listen: false,
                    //those just for testing the backend works perfectly and so the authentication
                  ).login("swoudgkwv@gmail.com", "As1#234567!");
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
                      'Log in',
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
                  Text('Don\'t have an account?'),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      ); // Navigate back to login page
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
