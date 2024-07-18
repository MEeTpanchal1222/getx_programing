import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/controller/theme_controller.dart';


class HomePage2 extends StatelessWidget {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Theme Change'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: themeController.toggleTheme,
          child: Text('Toggle Theme'),
        ),
      ),
    );
  }
}
