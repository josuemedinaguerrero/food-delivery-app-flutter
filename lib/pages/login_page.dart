import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/signup_page.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.75,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          ),
          Container(
            margin: EdgeInsets.only(top: 60, left: 25, right: 25),
            child: Column(
              children: [
                Center(child: Image.asset('images/logo.png', width: MediaQuery.of(context).size.width / 2)),
                SizedBox(height: 50),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text('Login', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        SizedBox(height: 40),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                            prefixIcon: Icon(Icons.password_outlined),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password?', style: WidgetSupport.boldTextStyle(color: Colors.black87, fontSize: 15)),
                        ),
                        SizedBox(height: 70),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            width: MediaQuery.of(context).size.width / 3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Color(0xffff5722), borderRadius: BorderRadius.circular(25)),
                            child: Text('LOGIN', style: WidgetSupport.boldTextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70),
                GestureDetector(
                  child: Text("Don't have an account? Sign up", style: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
