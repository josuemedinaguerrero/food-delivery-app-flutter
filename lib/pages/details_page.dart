import 'package:flutter/material.dart';
import 'package:food_delivery_getx/service/database.dart';
import 'package:food_delivery_getx/service/shared_preferences.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class DetailsPage extends StatefulWidget {
  final String name, image, detail, price;

  const DetailsPage({super.key, required this.detail, required this.image, required this.name, required this.price});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int a = 1, total = 0;

  @override
  void initState() {
    super.initState();

    total = int.parse(widget.price);
    setState(() {});
  }

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
            SizedBox(height: 15),
            Image.network(widget.image),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name, style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (a > 1) {
                        a--;
                        total = total - int.parse(widget.price);
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
                    a++;
                    total = total + int.parse(widget.price);

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(widget.detail, style: WidgetSupport.boldTextStyle(color: Colors.black38, fontSize: 15)),
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
                      Text("\$$total", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      final id = await SharedPreferencesHelpers().getUserId();
                      Map<String, dynamic> addFoodToCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image,
                      };

                      await DatabaseMethods().addFoodToCart(addFoodToCart, id ?? '3187666501');

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text("Food Added to Cart!", style: TextStyle(fontSize: 18.0))));
                      Navigator.pop(context);
                    },
                    child: Container(
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
