import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/home_admin_page.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _loginAdmin() async {
    final res = await FirebaseFirestore.instance.collection('admin').where('Id', isEqualTo: usernameController.text).where('Password', isEqualTo: passwordController.text).get();

    if (!mounted) return;
    if (res.docs.isEmpty) return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent, content: Text("Your user don't exist")));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text("Sesión iniciada correctamente!")));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeAdminPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromARGB(255, 53, 51, 51), Colors.black], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0))),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text("Let's start with\nAdmin!", style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 30),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(height: 50.0),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 160, 160, 147)), borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(border: InputBorder.none, hintText: "Username", hintStyle: TextStyle(color: Color.fromARGB(255, 160, 160, 147))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Please Enter Username';
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 160, 160, 147)), borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(border: InputBorder.none, hintText: "Password", hintStyle: TextStyle(color: Color.fromARGB(255, 160, 160, 147))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Please Enter Password';
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                _loginAdmin();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text("Log In", style: WidgetSupport.boldTextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
