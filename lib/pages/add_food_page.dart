import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_getx/service/database.dart';
import 'package:food_delivery_getx/widget/widget_support.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  final List<String> fooditems = ['Ice-cream', 'Burger', 'Salad', 'Pizza'];
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? value;

  Future _getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {});
  }

  _uploadItem() async {
    if (selectedImage != null && nameController.text != "" && priceController.text != "" && detailsController.text != "") {
      const urlImg =
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.instabug.com%2Fblog%2F12-essential-tools-for-the-flutter-mobile-app-developer&psig=AOvVaw3PHkaqnK2M66QMLUWk6p7W&ust=1738586273442000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOCk9t6ApYsDFQAAAAAdAAAAABAE';

      Map<String, dynamic> addItem = {"Image": urlImg, "Name": nameController.text, "Price": priceController.text, "Detail": detailsController.text};
      await DatabaseMethods().addFoodItem(addItem, 'items').then((value) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text("Food Item has been added Successfully", style: TextStyle(fontSize: 18.0))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Item", style: WidgetSupport.boldTextStyle(color: Colors.black)),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF373866)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload the Item Picture", style: WidgetSupport.boldTextStyle(color: Colors.black)),
              SizedBox(height: 20),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        _getImage();
                      },
                      child: Center(
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(Icons.camera_alt_outlined, color: Colors.black, size: 40),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(selectedImage!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30.0),
              Text("Item Name", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: WidgetSupport.boldTextStyle(color: Colors.black38),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Item Price", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                    hintText: "Enter Item Price",
                    hintStyle: WidgetSupport.boldTextStyle(color: Colors.black38),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Item Detail", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: detailsController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                    hintText: "Enter Item Detail",
                    hintStyle: WidgetSupport.boldTextStyle(color: Colors.black38),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Item Detail", style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFFececf8), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: fooditems
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: TextStyle(fontSize: 18.0, color: Colors.black)),
                          ),
                        )
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("Add", style: WidgetSupport.boldTextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
