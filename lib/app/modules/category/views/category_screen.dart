import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../logic/model/doctor_model.dart';
import '../../../logic/service/doctor_service.dart';
import '../../details/views/doctor_details_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  CategoryScreen({super.key, required this.category});
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(),
              FutureBuilder(
                  future: firestoreService.getDoctorsByCategory(category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Lottie.asset('assets/animations/empty.json',
                            fit: BoxFit.cover),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DoctorModel doctor = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                    () => DoctorDetailsScreen(doctor: doctor));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: defaultPadding),
                                padding: const EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1)),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Doctor image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(doctor.image,
                                          width: 80,
                                          height: 100,
                                          fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doctor.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(doctor.category,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text.rich(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    TextSpan(
                                                      text: "Experience: ",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: textColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "${doctor.experience} years",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text.rich(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    TextSpan(
                                                      text: "Institution: ",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: textColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              doctor.institute,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
