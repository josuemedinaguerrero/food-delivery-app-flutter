import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/details_page.dart';
import 'package:food_delivery_getx/service/database.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "images/ice-cream.png",
    "images/pizza.png",
    "images/salad.png",
    "images/burger.png",
  ];

  final List<String> items = ['Ice-cream', 'Pizza', 'Salad', 'Burger'];

  Stream? foodItems;
  int selectedCategory = 0;

  _getItem() async {
    foodItems = DatabaseMethods().getFoodItem('Burger');
    setState(() {});
  }

  @override
  void initState() {
    _getItem();

    super.initState();
  }

  void _selectCategory(int index) {
    selectedCategory = index;

    foodItems = DatabaseMethods().getFoodItem(items[index]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 25, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello, Josué', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.shopping_cart, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Delicious Food', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
            Text('Discover and Get Great Food', style: WidgetSupport.boldTextStyle(color: Colors.black38, fontSize: 15)),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(images.length, (index) => _showItem(images[index], index)),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 300, child: _allItems()),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/salad2.png', width: MediaQuery.of(context).size.width / 3.5, fit: BoxFit.cover),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text('Mediaterranean Chickpea Salad', style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text('Honey goot cheese', style: WidgetSupport.boldTextStyle(color: Colors.black38, fontSize: 15)),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text('\$28', style: WidgetSupport.boldTextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _showItem(String img, int index) {
    return GestureDetector(
      onTap: () => _selectCategory(index),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: selectedCategory == index ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            img,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            color: selectedCategory == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _allItems() {
    return StreamBuilder(
        stream: foodItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              detail: ds['Detail'],
                              image: ds['Image'],
                              name: ds['Name'],
                              price: ds['Price'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(ds['Image'], height: 170, width: 150, fit: BoxFit.cover),
                                ),
                                SizedBox(height: 5),
                                Text(ds['Name'], style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text(ds['Detail'], style: WidgetSupport.boldTextStyle(color: Colors.black54, fontSize: 15)),
                                SizedBox(height: 3),
                                Text('\$${ds['Price']}', style: WidgetSupport.boldTextStyle(color: Colors.black, fontSize: 17)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator();
        });
  }
}
