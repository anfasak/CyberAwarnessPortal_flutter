// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _searchController = TextEditingController();

//   final List<Map<String, String>> _allExploreItems = [
//     {
//       "title": "Awareness Videos",
//       "subtitle": "Watch & Learn",
//       "image":
//           "https://images.unsplash.com/photo-1581092334651-ddf26d9a09d0",
//     },
//     {
//       "title": "Cyber Tips",
//       "subtitle": "Daily safety tips",
//       "image":
//           "https://images.unsplash.com/photo-1600267185393-e158a98703de",
//     },
//     {
//       "title": "Phishing",
//       "subtitle": "Identify fake links",
//       "image":
//           "https://images.unsplash.com/photo-1550751827-4bd374c3f58b",
//     },
//     {
//       "title": "Privacy",
//       "subtitle": "Protect your data",
//       "image":
//           "https://images.unsplash.com/photo-1614064641938-3bbee52942c7",
//     },
//     {
//       "title": "Cyber Quiz",
//       "subtitle": "Test knowledge",
//       "image":
//           "https://images.unsplash.com/photo-1596495577886-d920f1fb7238",
//     },
//     {
//       "title": "Report Scam",
//       "subtitle": "Raise complaints",
//       "image":
//           "https://images.unsplash.com/photo-1557200134-90327ee9fafa",
//     },
//   ];

//   List<Map<String, String>> _filteredExploreItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredExploreItems = _allExploreItems;
//   }

//   void _filterExplore(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredExploreItems = _allExploreItems;
//       } else {
//         _filteredExploreItems = _allExploreItems
//             .where((item) =>
//                 item["title"]!
//                     .toLowerCase()
//                     .contains(query.toLowerCase()) ||
//                 item["subtitle"]!
//                     .toLowerCase()
//                     .contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               /// 🔹 TOP BAR
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Icon(Icons.menu, size: 28),
//                   const CircleAvatar(
//                     radius: 20,
//                     backgroundImage:
//                         NetworkImage("https://i.pravatar.cc/150"),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 0),

//               /// 🔹 WELCOME
//               const Text(
//                 "Welcome back,",
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//               const SizedBox(height: 2),
//               const Text(
//                 "Cyber Guardian 👋",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 24),

//               /// 🔹 SEARCH BAR (CONNECTED TO EXPLORE)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 10,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: _filterExplore,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Search explore content",
//                     icon: Icon(Icons.search),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               /// 🔹 EXPLORE
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Explore",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),

//               const SizedBox(height:20),

//               _filteredExploreItems.isEmpty
//                   ? const Center(
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 40),
//                         child: Text(
//                           "No content found",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                       ),
//                     )
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 16,
//                         crossAxisSpacing: 20,
//                         childAspectRatio: 1.25,
//                       ),
//                       itemCount: _filteredExploreItems.length,
//                       itemBuilder: (context, index) {
//                         final item = _filteredExploreItems[index];
//                         return _ExploreCard(
//                           title: item["title"]!,
//                           subtitle: item["subtitle"]!,
//                           image: item["image"]!,
//                         );
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// 🔹 EXPLORE CARD
// class _ExploreCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String image;

//   const _ExploreCard({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 100,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius:
//                 const BorderRadius.vertical(top: Radius.circular(18)),
//             child: Image.network(
//               image,
//               height: 50,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cyberguard/Register.dart';
import 'package:cyberguard/contentdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// final Dio dio = Dio();


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> exploreItems = [];
  List<dynamic> filteredExploreItems = [];

  @override
  void initState() {
    super.initState();
    fetchExploreContent();
  }

  /// 🔹 FETCH CONTENT FROM DJANGO
  Future<void> fetchExploreContent() async {
    try {
      final response =
          await dio.get('$baseurl/viewcontents');

          print(response.data);

      if (response.statusCode == 200) {
        setState(() {
          exploreItems = response.data;
          filteredExploreItems = exploreItems;
        });
      }
    } catch (e) {
      debugPrint("EXPLORE API ERROR: $e");
    }
  }

  /// 🔹 SEARCH
  void _filterExplore(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredExploreItems = exploreItems;
      } else {
        filteredExploreItems = exploreItems.where((item) {
          return item['Content']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item['ThreatType']
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.menu, size: 28),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150"),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text("Welcome back,",
                  style: TextStyle(color: Colors.black54)),
              const Text(
                "Cyber Guardian 👋",
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// SEARCH
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterExplore,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search explore content",
                    icon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("Explore",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),

              const SizedBox(height: 20),

              filteredExploreItems.isEmpty
                  ? const Center(child: Text("No content found"))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 18,
                        childAspectRatio: 0.90
                      ),
                      itemCount: filteredExploreItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredExploreItems[index];
                        return ExploreCard(
                          title: item['Content'],
                          subtitle: item['ThreatType'],
                          image:
                              "$baseurl${item['image']}",
                          data: item,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 EXPLORE CARD (UNCHANGED UI)
class ExploreCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Map<String, dynamic> data;

  const ExploreCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExploreDetailPage(data: data),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.network(
                image,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

