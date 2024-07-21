import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/basic_app/controller/counter_controller.dart';

class CounterPage extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Counter'),
      ),
      body: Center(
        child: Obx(() => Text('Count: ${counterController.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
