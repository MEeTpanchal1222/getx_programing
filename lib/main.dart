import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/controller/theme_controller.dart';
import 'package:getx_programing/view/counter/counter_page.dart';
import 'package:getx_programing/view/pageroute/page_1.dart';
import 'package:getx_programing/view/pageroute/page_2.dart';
import 'package:getx_programing/view/theme_page/page.dart';



void main() {
  runApp(MyApp3());
}


class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CounterPage(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      getPages: [
        GetPage(name: '/home', page: () => HomePage(),transition: Transition.cupertino),
        GetPage(name: '/second', page: () => SecondPage(),transition: Transition.cupertino),
      ],
    );
  }
}

class MyApp3 extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: themeController.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
        home: HomePage2(),
      );
    });
  }
}

