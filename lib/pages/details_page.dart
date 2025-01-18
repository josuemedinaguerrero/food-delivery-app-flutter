import 'package:flutter/material.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int a = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Image.asset("images/salad2.png"),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mediterranean', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      Text('Chickpea Salad', style: WidgetSupport.boldTextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (a > 1) {
                        a--;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Text(a.toString(), style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      a++;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus vitae, tincidunt sapien. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nib',
              style: WidgetSupport.boldTextStyle(color: Colors.black38, fontSize: 15),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Delivery Time', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 25),
                Icon(Icons.alarm, color: Colors.black54),
                SizedBox(width: 5),
                Text('30 min', style: WidgetSupport.boldTextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
            SizedBox(height: 15),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      Text("\$28", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 7, bottom: 7, left: 20, right: 20),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Text('Add to cart', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 15),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
