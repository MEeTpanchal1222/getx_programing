import 'package:get/get.dart';
import 'package:getx_programing/KBC_quiz_app/modal/question.dart';
import 'package:getx_programing/KBC_quiz_app/view/quiz_view.dart';
import 'package:getx_programing/KBC_quiz_app/view/result_view.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;//index of questions
  var score = 0.obs;//score count
  var wrongAttempts = 0.obs;//wrong attempts counts

  final List<Question> questions = [
    Question(
      questionText: 'What is the capital of France?',
      options: ['Berlin', 'Madrid', 'Paris', 'Lisbon'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Who wrote "Romeo and Juliet"?',
      options: [
        'William Shakespeare',
        'Mark Twain',
        'Jane Austen',
        'Charles Dickens'
      ],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'What is the smallest planet in our solar system?',
      options: ['Mars', 'Earth', 'Mercury', 'Venus'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Which ocean is the largest?',
      options: [
        'Atlantic Ocean',
        'Indian Ocean',
        'Arctic Ocean',
        'Pacific Ocean'
      ],
      correctOptionIndex: 3,
    ),
    Question(
      questionText: 'What is the chemical symbol for gold?',
      options: ['Au', 'Ag', 'Go', 'Gd'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Which country is known as the Land of the Rising Sun?',
      options: ['China', 'South Korea', 'Japan', 'Thailand'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'How many continents are there?',
      options: ['5', '6', '7', '8'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'What is the hardest natural substance on Earth?',
      options: ['Gold', 'Iron', 'Diamond', 'Platinum'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Who is known as the father of computers?',
      options: [
        'Albert Einstein',
        'Isaac Newton',
        'Charles Babbage',
        'Nikola Tesla'
      ],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'What is the main ingredient in guacamole?',
      options: ['Tomato', 'Avocado', 'Onion', 'Lettuce'],
      correctOptionIndex: 1,
    ),
  ];

  void checkAnswer(int selectedOptionIndex) {
    if (questions[currentQuestionIndex.value].correctOptionIndex ==
        selectedOptionIndex) {
      score++;
      wrongAttempts.value = 0;
    } else {
      wrongAttempts++;
    }

    if (wrongAttempts.value == 3) {
      Get.toNamed("/Result");
      //resetQuiz();
    } else {
      nextQuestion();
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
    } else {
      Get.toNamed("/Result");
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    score.value = 0;
    wrongAttempts.value = 0;
  }
}
