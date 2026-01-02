import 'package:cyberguard/Register.dart';
import 'package:cyberguard/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// -----------------------------
/// CONFIG (CHANGE AS NEEDED)
/// -----------------------------
// final Dio dio = Dio();
// const String baseurl = "http://YOUR-IP:000"; // 🔴 change
// const int loginid = 4; // 🔴 dynamic later

/// -----------------------------
/// MODEL
/// -----------------------------
class ComplaintModel {
  final int id;
  final String complaint;
  final String? reply;
  final String date;

  ComplaintModel({
    required this.id,
    required this.complaint,
    this.reply,
    required this.date,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      complaint: json['Complaint'],
      reply: json['Reply'],
      date: json['Date'],
    );
  }
}

/// -----------------------------
/// PAGE
/// -----------------------------
class SendComplaint extends StatefulWidget {
  const SendComplaint({super.key});

  @override
  State<SendComplaint> createState() => _SendComplaintState();
}

class _SendComplaintState extends State<SendComplaint> {

  final FocusNode _focusNode = FocusNode();

  
  final TextEditingController _complaintCtrl = TextEditingController();
  

  List<ComplaintModel> complaints = [];

  // Theme colors
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color cardDark = Color(0xFF1A1F25);
  static const Color neon = Color(0xFF00E5FF);

  /// -----------------------------
  /// POST COMPLAINT
  /// -----------------------------
  Future<void> postComplaint() async {
    if (_complaintCtrl.text.trim().isEmpty) return;

    try {
      final response = await dio.post(
        '$baseurl/complaint/$loginid',
        data: {
          'Complaint': _complaintCtrl.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _complaintCtrl.clear();
        await getComplaints();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complaint submitted")),
        );
      }
    } catch (e) {
      debugPrint("POST ERROR: $e");
    }
  }

  /// -----------------------------
  /// GET COMPLAINTS
  /// -----------------------------
  Future<void> getComplaints() async {
    try {
      final response = await dio.get('$baseurl/complaint/$loginid');

      if (response.statusCode == 200) {
        final data = response.data;

        setState(() {
          if (data is List) {
            complaints =
                data.map((e) => ComplaintModel.fromJson(e)).toList();
          } else {
            complaints = [ComplaintModel.fromJson(data)];
          }
        });
      }
    } catch (e) {
      debugPrint("GET ERROR: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getComplaints();
  }

  @override
  void dispose() {
    _complaintCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// -----------------------------
  /// UI
  /// -----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Complaint Box",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildComplaintForm(),
            const SizedBox(height: 30),
            _buildComplaintList(),
          ],
        ),
      ),
    );
  }

  /// -----------------------------
  /// COMPLAINT FORM
  /// -----------------------------
  Widget _buildComplaintForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: neon.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Submit Complaint",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _complaintCtrl,
            focusNode: _focusNode,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Write your complaint...",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF0F1419),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: neon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: postComplaint,
              child: const Text(
                "SUBMIT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// -----------------------------
  /// COMPLAINT LIST
  /// -----------------------------
  Widget _buildComplaintList() {
    if (complaints.isEmpty) {
      return const Center(
        child: Text(
          "No complaints yet",
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: complaints.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          _buildComplaintCard(complaints[index]),
    );
  }

  /// -----------------------------
  /// COMPLAINT CARD
  /// -----------------------------
  Widget _buildComplaintCard(ComplaintModel item) {
    final bool isResolved =
        item.reply != null && item.reply!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isResolved ? Colors.greenAccent : Colors.orangeAccent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.complaint,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isResolved
                ? "Reply: ${item.reply}"
                : "Status: Pending",
            style: TextStyle(
              color:
                  isResolved ? Colors.greenAccent : Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.date,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
