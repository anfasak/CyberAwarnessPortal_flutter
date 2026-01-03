import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cyberguard/Register.dart';
import 'package:cyberguard/login.dart';

final Dio dio = Dio();

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int total = 0;
  int correct = 0;
  int attempted = 0;
  bool loading = true;

  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    getResult();
  }

  /// 🔹 FETCH RESULT FROM BACKEND
  Future<void> getResult() async {
    try {
      final response = await dio.get('$baseurl/ViewResult/$loginid');
      debugPrint("Result Response: ${response.data}");

      if (response.statusCode == 200) {
        setState(() {
          total = response.data['total_questions'];

           correct = response.data['correct_answers'];
           attempted = response.data['attempted'];

          // ✅ FIX (WITHOUT CHANGING ANY OTHER LOGIC)
          // correct = apiCorrect > total ? total : apiCorrect;
          // attempted = apiAttempted > total ? total : apiAttempted;

          results = List<Map<String, dynamic>>.from(
            response.data['results'],
          );

          loading = false;
        });
      }
    } catch (e) {
      debugPrint("RESULT API ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        title: const Text("Quiz Result"),
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
                children: [

                  /// 🔹 SCORE CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF00E5FF)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Your Score",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "$correct / $attempted",
                          style: const TextStyle(
                            color: Color(0xFF00E5FF),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Attempted: $attempted",
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// 🔹 RESULT LIST
                  Expanded(
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final item = results[index];
                        final bool isCorrect = item["is_correct"];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161B22),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCorrect
                                  ? Colors.green
                                  : Colors.redAccent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isCorrect
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: isCorrect
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item["question"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
