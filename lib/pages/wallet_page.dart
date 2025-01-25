import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final List amounts = [100, 500, 1000, 2000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Material(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(child: Text('Wallet', style: WidgetSupport.boldTextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold))),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
              child: Row(
                children: [
                  Image.asset('images/wallet.png', height: 60),
                  SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Wallet", style: WidgetSupport.boldTextStyle(color: Colors.black26, fontSize: 13, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("\$100", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Money", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(amounts.length, (index) => _itemAmount(amounts[index])),
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckoutView(
                          sandboxMode: true,
                          clientId: dotenv.get('CLIENT_ID_PAYPAL'),
                          secretKey: dotenv.get('CLIENT_SECRET_PAYPAL'),
                          transactions: const [
                            {
                              "amount": {
                                "total": '100',
                                "currency": "USD",
                                "details": {"subtotal": '100', "shipping": '0', "shipping_discount": 0}
                              },
                              "description": "The payment transaction description.",
                              "item_list": {
                                "items": [
                                  {"name": "Apple", "quantity": 4, "price": '10', "currency": "USD"},
                                  {"name": "Pineapple", "quantity": 5, "price": '12', "currency": "USD"}
                                ],
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            log("onSuccess: ${jsonEncode(params)}");
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text("Payment Successful"),
                                  ],
                                ),
                              ),
                            );
                          },
                          onError: (error) {
                            log("onError: ${jsonEncode(error)}");
                            log("ERROR: ${error['data']['details'][0]['issue']}");
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            log('cancelled:');
                            Navigator.pop(context);
                          },
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF008080), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('Add Money', style: WidgetSupport.boldTextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _itemAmount(int amount) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE9E2E2)), borderRadius: BorderRadius.circular(5)),
      child: Text("\$${amount.toString()}", style: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
