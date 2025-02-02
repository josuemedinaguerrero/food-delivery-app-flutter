import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/add_food_page.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(child: Text("Home Admin", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25))),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddFoodPage()));
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Image.asset("images/food.jpg", height: 100, width: 100, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 30),
                        Text("Add Food Items", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
