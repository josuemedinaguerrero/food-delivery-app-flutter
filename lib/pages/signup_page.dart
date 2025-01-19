import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/login_page.dart';
import 'package:food_delivery_getx/widget/bottom_nav.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginState();
}

class _LoginState extends State<SignupPage> {
  String email = "", password = "", name = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _registration() async {
    if (password != '') {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('Registered Successfully', style: WidgetSupport.boldTextStyle(color: Colors.black))));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "An error has ocurred!", style: WidgetSupport.boldTextStyle(color: Colors.black))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFff5c30), Color(0xFFe74b1a)]),
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
                    height: MediaQuery.of(context).size.height / 1.8,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text('Sign up', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          SizedBox(height: 40),
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please Enter Name';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: mailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please Enter Email';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please Enter Password';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                              prefixIcon: Icon(Icons.password_outlined),
                            ),
                          ),
                          SizedBox(height: 70),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() {
                                  email = mailController.text;
                                  name = nameController.text;
                                  password = passwordController.text;
                                });
                              }

                              _registration();
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Color(0xffff5722), borderRadius: BorderRadius.circular(25)),
                                child: Text('SIGN UP', style: WidgetSupport.boldTextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                GestureDetector(
                  child: Text("Already have an a ccount? Login", style: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
