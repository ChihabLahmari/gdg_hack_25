import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/core/widgets/my_text_button.dart';
import 'package:my_template/features/home/data/models/quiz.dart';
import 'package:my_template/features/home/logic/cubit/home_cubit.dart';

// 🟢 Generate Test Quizzes
// 🟢 Generate Test Quizzes for JavaScript
List<Quiz> generateTestQuizzes() {
  return [
    Quiz(
      question: "Which method is used to add an element to the end of an array in JavaScript?",
      options: ["push()", "pop()", "shift()", "unshift()"],
      correctAnswer: "push()",
    ),
    Quiz(
      question: "What is the output of `console.log(1 + '1')` in JavaScript?",
      options: ["11", "2", "NaN", "undefined"],
      correctAnswer: "11",
    ),
    Quiz(
      question: "Which function is used to execute a piece of code after a specified delay in JavaScript?",
      options: ["setTimeout()", "setInterval()", "delay()", "wait()"],
      correctAnswer: "setTimeout()",
    ),
    Quiz(
      question: "What is the purpose of the `this` keyword in JavaScript?",
      options: [
        "Refers to the object that owns the executing code",
        "Refers to the current function",
        "Refers to the global object",
        "Refers to the parent object"
      ],
      correctAnswer: "Refers to the object that owns the executing code",
    ),
    Quiz(
      question: "What does the `map()` method do in JavaScript?",
      options: [
        "Creates a new array with the results of calling a function on every element",
        "Filters elements based on a condition",
        "Reduces the array to a single value",
        "Sorts the array in ascending order"
      ],
      correctAnswer: "Creates a new array with the results of calling a function on every element",
    ),
    Quiz(
      question: "What is the output of `console.log(typeof [])` in JavaScript?",
      options: ["object", "array", "undefined", "null"],
      correctAnswer: "object",
    ),
  ];
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Quiz> quizzes = generateTestQuizzes();
  int currentIndex = 0;
  String? selectedAnswer;
  int correctAnswers = 0;

  void nextQuestion() {
    if (selectedAnswer == quizzes[currentIndex].correctAnswer) {
      correctAnswers++;
    }

    if (currentIndex < quizzes.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
      });
    } else {
      // Navigate to result screen when all questions are done
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: correctAnswers, total: quizzes.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Quiz currentQuiz = quizzes[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz ${currentIndex + 1} of ${quizzes.length}"),
        centerTitle: true,
        backgroundColor: ColorsManager.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Question Text
            Text(
              currentQuiz.question,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Answer Options
            Expanded(
              child: ListView(
                children: currentQuiz.options.map((option) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAnswer = option;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: selectedAnswer == option ? ColorsManager.vibrantPink : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 18,
                            color: selectedAnswer == option ? ColorsManager.vibrantPink : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Confirm Button
            if (selectedAnswer != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: MyTextButton(
                  buttonText: currentIndex < quizzes.length - 1 ? "Confirm" : "Finish",
                  textStyle: TextStyles.p.copyWith(color: ColorsManager.white),
                  onPressed: nextQuestion,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 🟢 Result Screen
class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    bool isSuccess = score >= total / 2; // Pass if 50% or more is correct

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Result"),
        backgroundColor: ColorsManager.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSuccess ? "🎉 You Passed! 🎉" : "❌ You Failed ❌",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Score: $score / $total", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isSuccess) {
                  BlocProvider.of<HomeCubit>(context).incrementCompletedSteps();
                }
                Navigator.pop(context);
              },
              child: Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
