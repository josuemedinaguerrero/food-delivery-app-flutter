import 'package:flutter/material.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

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
                    onPressed: () {},
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

  _itemAmount(double amount) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE9E2E2)), borderRadius: BorderRadius.circular(5)),
      child: Text("\$${amount.toString()}", style: WidgetSupport.boldTextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
