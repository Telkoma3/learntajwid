import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/app/modules/article/views/article_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/section_title.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('article').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No articles found'),
          );
        }

        final blogs = snapshot.data!.docs;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 5, right: 15, left: 15),
              child: SectionTitle(
                title: "Tahsin Tips",
                pressOnSeeAll: () {},
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < blogs.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ArticleDetails(blog: blogs[i]));
                        },
                        child: Container(
                          height: 160,
                          width: screenSize.width / 1.3,
                          clipBehavior: Clip.antiAlias,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Stack(
                            children: [
                              blogs[i]['image'] != null
                                  ? Image.network(blogs[i]['image'],
                                      height: 160,
                                      width: double.infinity,
                                      fit: BoxFit.cover)
                                  : Image.asset('assets/logo/logo.png',
                                      height: 160,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                              Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                    Colors.white.withOpacity(1),
                                    Colors.white.withOpacity(0.1)
                                  ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter))),
                              // Content overlay
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        blogs[i]['category'] ??
                                            "Unknown Category",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor)),
                                    const Spacer(),
                                    Text(
                                      blogs[i]['title'] ??
                                          'No Title Available', // Fetching article title
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: textColor),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'September 12, 2024', // Fetching date
                                      style: TextStyle(
                                          fontSize: 12, color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        );
      },
    );
  }
}
