import 'package:cyberguard/Register.dart';
import 'package:cyberguard/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SendFeedback extends StatefulWidget {
  const SendFeedback({super.key});

  @override
  State<SendFeedback> createState() => _SendFeedbackState();
}
TextEditingController feedback=TextEditingController();
double _rating = 3;

class _SendFeedbackState extends State<SendFeedback> {
  final Color bgDark = const Color(0xFF0D1117);
  final Color cardDark = const Color(0xFF1A1F25);
  final Color neon = const Color(0xFF00E5FF);


   Future<void> post_feedback(content) async {
  try {
    final response = await dio.post(
    '$baseurl/feedback/$loginid',
    data:{
    'Feedback':feedback.text,
    'Rating':_rating
    }
    );
     
    print(response.data);

    if(response.statusCode==200|| response.statusCode==201) {

        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('submitted successfully')),
        );
    } else{
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('failed'))
      );
    }
    
  } catch (e) {
    print("error: $e");
  }

}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width >= 900 ? 550.0 : width * 0.92;

    return Scaffold(
      backgroundColor: bgDark,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 78,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00E5FF), Color(0xFF3BE8FF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: neon.withOpacity(0.7),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Send Feedback",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F151A), Color(0xFF1A1F25)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white12),
              boxShadow: [
                BoxShadow(
                  color: neon.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Rate Your Experience",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Help us improve our Cyber Awareness content",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 25),

                // Rating Bar
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  itemSize: 40,
                  unratedColor: Colors.white12,
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: neon,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Cyber TextField with Neon Glow
                _buildCyberTextField(
                  label: "Your Feedback",
                  maxLines: 5,
                  controller: feedback
                ),

                const SizedBox(height: 30),

                // Neon Gradient Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {post_feedback(context);},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            neon,
                            const Color(0xFF3BE8FF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: neon.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Neon Cyber TextField Builder ---
  Widget _buildCyberTextField({required String label, int maxLines = 1,TextEditingController? controller}) {
    return Focus(
      child: Builder(builder: (context) {
        final hasFocus = Focus.of(context).hasFocus;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1419),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasFocus ? neon : Colors.white24,
              width: hasFocus ? 1.6 : 1.0,
            ),
            boxShadow: hasFocus
                ? [
                    BoxShadow(
                      color: neon.withOpacity(0.2),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            maxLines: maxLines,
            controller: controller,
            style: const TextStyle(color: Colors.white),
            cursorColor: neon,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none,
              alignLabelWithHint: true,
            ),
          ),
        );
      }),
    );
  }
}
