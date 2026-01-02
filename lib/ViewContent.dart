import 'package:flutter/material.dart';

class Viewcontent extends StatefulWidget {
  const Viewcontent({super.key});

  @override
  State<Viewcontent> createState() => _ViewcontentState();
}

class _ViewcontentState extends State<Viewcontent> {
  final List<Map<String, dynamic>> cyberTips = [
    {
      "title": "Phishing Attacks",
      "desc":
          "Never click suspicious links or open unknown email attachments. Always verify the sender.",
      "icon": Icons.phishing,
    },
    {
      "title": "Strong Passwords",
      "desc":
          "Use long passwords with a mix of letters, numbers and symbols. Avoid reuse.",
      "icon": Icons.lock_outline,
    },
    {
      "title": "Public Wi-Fi Safety",
      "desc":
          "Avoid logging into sensitive accounts using public Wi-Fi networks.",
      "icon": Icons.wifi_off,
    },
    {
      "title": "Two-Factor Authentication",
      "desc":
          "Enable 2FA wherever possible for extra account protection.",
      "icon": Icons.security,
    },
    {
      "title": "Software Updates",
      "desc":
          "Keep your system and apps updated to fix security vulnerabilities.",
      "icon": Icons.system_update_alt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF00E5FF), Color(0xFF3BE8FF)],
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Cyber Awareness",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: cyberTips.length,
          itemBuilder: (context, index) {
            final item = cyberTips[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF161B22), Color(0xFF0D1117)],
                ),
                border: Border.all(
                  color: Colors.cyanAccent.withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyanAccent.withOpacity(0.15),
                    ),
                    child: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.cyanAccent,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item["desc"],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
