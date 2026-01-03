import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Register.dart';
import 'login.dart';

final Dio dio = Dio();

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;

  String question = "";
  int? quizId;
  List<dynamic> options = [];

  int selectedOption = -1;
  bool loading = true;
  bool quizLocked = false;

  /// ✅ USER-SPECIFIC KEY (FIX)
  String get quizKey => 'quiz_completed_$loginid';

  @override
  void initState() {
    super.initState();
    checkQuizStatus();
  }

  /// 🔹 CHECK IF THIS USER ALREADY COMPLETED QUIZ
  Future<void> checkQuizStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool completed = prefs.getBool(quizKey) ?? false;

    if (completed) {
      setState(() {
        quizLocked = true;
        loading = false;
        question = "You already completed the quiz";
        options = [];
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You already completed the quiz"),
          ),
        );
      });
    } else {
      getQuestions();
    }
  }

  /// 🔹 LOAD QUIZ QUESTIONS
  Future<void> getQuestions() async {
    try {
      final response = await dio.get('$baseurl/viewquiz');

      if (response.statusCode == 200 && response.data.isNotEmpty) {
        setState(() {
          questions = response.data;
          loadQuestion(0);
          loading = false;
        });
      }
    } catch (e) {
      debugPrint("QUIZ LOAD ERROR: $e");
    }
  }

  /// 🔹 LOAD SINGLE QUESTION
  void loadQuestion(int index) {
    final q = questions[index];
    quizId = q['quiz_id'];
    question = q['question'];
    options = q['options'];
    selectedOption = -1;
  }

  /// 🔹 SUBMIT ANSWER
  Future<void> submitAnswer(int selectedIndex) async {
    try {
      await dio.post(
        '$baseurl/submit/$loginid',
        data: {
          "quiz_id": quizId,
          "selected_index": selectedIndex,
        },
      );
    } catch (e) {
      debugPrint("SUBMIT ERROR: $e");
    }
  }

  /// 🔹 MARK QUIZ AS COMPLETED (USER-WISE)
  Future<void> markQuizCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(quizKey, true);

    setState(() {
      quizLocked = true;
      question = "You already completed the quiz";
      options = [];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Quiz completed successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        title: const Text("Cyber Quiz"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00E5FF),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔹 QUESTION / MESSAGE
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF00E5FF)),
                    ),
                    child: Text(
                      question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// 🔹 OPTIONS (HIDDEN WHEN QUIZ LOCKED)
                  if (!quizLocked)
                    ...List.generate(options.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: selectedOption == index
                                ? const Color(0xFF00E5FF).withOpacity(0.2)
                                : const Color(0xFF161B22),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedOption == index
                                  ? const Color(0xFF00E5FF)
                                  : Colors.white24,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedOption == index
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: const Color(0xFF00E5FF),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  options[index]['text'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                  const Spacer(),

                  /// 🔹 NEXT / FINISH BUTTON
                  if (!quizLocked)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E5FF),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: selectedOption == -1
                            ? null
                            : () async {
                                int originalIndex =
                                    options[selectedOption]['index'];

                                await submitAnswer(originalIndex);

                                if (currentQuestionIndex <
                                    questions.length - 1) {
                                  setState(() {
                                    currentQuestionIndex++;
                                    loadQuestion(currentQuestionIndex);
                                  });
                                } else {
                                  await markQuizCompleted();
                                }
                              },
                        child: Text(
                          currentQuestionIndex == questions.length - 1
                              ? "Finish Quiz"
                              : "Next Question",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
