import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/KBC_quiz_app/controller/quiz_controller.dart';
import 'package:getx_programing/KBC_quiz_app/view/quiz_view.dart';

class ResultView extends StatelessWidget {
  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: ${quizController.score.value}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                quizController.resetQuiz();
                Get.offAll(() => QuizView());
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
