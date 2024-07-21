import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/Api_app/view/home_screen.dart';
import 'package:getx_programing/KBC_quiz_app/view/quiz_view.dart';
import 'package:getx_programing/KBC_quiz_app/view/result_view.dart';
import 'package:getx_programing/Login_signup_from_app/view/login_view.dart';
import 'package:getx_programing/Todo_list_app/view/todo_app.dart';
import 'package:getx_programing/basic_app/controller/theme_controller.dart';
import 'package:getx_programing/basic_app/view/counter/counter_page.dart';
import 'package:getx_programing/basic_app/view/pageroute/page_1.dart';
import 'package:getx_programing/basic_app/view/pageroute/page_2.dart';
import 'package:getx_programing/basic_app/view/theme_page/page.dart';




void main() {
  runApp(FORM_APP());
}


class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
        home: HomePage2(),
      );
    });
  }
}

class TODO_APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX CRUD Example',
      home: TodoApp(),
    );
  }
}



class FORM_APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(),
    );
  }
}

class API_APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostView(),
    );
  }
}


class KBC_APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizView(),
      getPages: [
        GetPage(name: '/home', page: () => QuizView(),transition: Transition.cupertino),
        GetPage(name: '/Result', page: () => ResultView(),transition: Transition.cupertino),
      ],
    );
  }
}