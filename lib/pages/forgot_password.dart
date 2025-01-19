import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/login_page.dart';
import 'package:food_delivery_getx/pages/signup_page.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController mailController = TextEditingController();

  _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('Email Sent Successfully!', style: WidgetSupport.boldTextStyle(color: Colors.black))));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.redAccent, content: Text(e.message ?? "An error has ocurred!", style: WidgetSupport.boldTextStyle(color: Colors.black))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 25),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text('Password Recovery', style: WidgetSupport.boldTextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Text('Enter your mail', style: WidgetSupport.boldTextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(border: Border.all(color: Colors.white70, width: 2), borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: mailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please Enter Email';
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: WidgetSupport.boldTextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                              prefixIcon: Icon(Icons.person_outline, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 5, backgroundColor: Colors.white),
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() {
                                email = mailController.text;
                              });
                            }

                            _resetPassword();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text('Send Email', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?", style: WidgetSupport.boldTextStyle(color: Colors.white, fontSize: 15)),
                            SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                              },
                              child: Text('Create', style: WidgetSupport.boldTextStyle(color: Colors.amber, fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
