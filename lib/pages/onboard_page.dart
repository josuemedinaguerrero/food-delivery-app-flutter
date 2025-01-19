import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/login_page.dart';
import "package:food_delivery_getx/widget/content_model.dart";
import 'package:food_delivery_getx/widget/widget_support.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: contents.length,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset(contents[index].image, height: 450, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
                        SizedBox(height: 40),
                        Text(contents[index].description, textAlign: TextAlign.center, style: WidgetSupport.boldTextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(contents[index].title, style: WidgetSupport.boldTextStyle(color: Colors.black, fontSize: 16)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(contents.length, (index) => _buildDot(index)),
            ),
            GestureDetector(
              onTap: () {
                if (currentIndex == contents.length - 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(25)),
                margin: EdgeInsets.all(40),
                width: double.infinity,
                child: Text(currentIndex == contents.length - 1 ? 'Start' : 'Next', style: WidgetSupport.boldTextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDot(int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
