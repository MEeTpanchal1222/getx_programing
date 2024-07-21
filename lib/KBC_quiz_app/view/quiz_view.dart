import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/KBC_quiz_app/controller/quiz_controller.dart';

class QuizView extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Obx(() {
        final question = quizController.questions[quizController.currentQuestionIndex.value];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                question.questionText,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              for (int i = 0; i < question.options.length; i++)
                ElevatedButton(
                  onPressed: () {
                    quizController.checkAnswer(i);
                    //quizController.
                  },
                  child: Text(question.options[i]),
                ),
            ],
          ),
        );
      }),
    );
  }
}
