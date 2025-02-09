import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/service/database.dart';
import 'package:food_delivery_getx/service/shared_preferences.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int total = 0, amount2 = 0;
  Stream? foodStream;
  String? id, wallet;

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      amount2 = total;
      setState(() {});
    });
  }

  getthesharedpref() async {
    id = await SharedPreferencesHelpers().getUserId();
    wallet = await SharedPreferencesHelpers().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(child: Text("Food Cart", style: WidgetSupport.boldTextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold))),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).size.height / 2, child: _foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price", style: WidgetSupport.boldTextStyle(color: Colors.black)),
                  Text("\$$total", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // int amount = int.parse(wallet!) - amount2;
                // await DatabaseMethods().UpdateUserwallet(id!, amount.toString());
                // await SharedPreferenceHelper().saveUserWallet(amount.toString());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(child: Text("CheckOut", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = total + int.parse(ds["Total"]);
                    return Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 40,
                                decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text(ds["Quantity"])),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  Text(ds["Name"], style: WidgetSupport.boldTextStyle(color: Colors.black)),
                                  Text("\$${ds["Total"]}", style: WidgetSupport.boldTextStyle(color: Colors.black))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }
}
