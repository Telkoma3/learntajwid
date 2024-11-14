import 'package:doctor_appointment/app/logic/model/doctor_model.dart';
import 'package:doctor_appointment/widgets/app_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/section_title.dart';
import '../../../logic/service/doctor_service.dart';
import '../../details/views/doctor_details_screen.dart';
import '../../doctors/views/doctors_screen.dart';

class AvailableDoctors extends StatelessWidget {
  AvailableDoctors({super.key});

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 5, right: 15, left: 15),
          child: SectionTitle(
            title: "Available Ustadz",
            pressOnSeeAll: () {
              Get.to(() => DoctorsScreen());
            },
          ),
        ),
        FutureBuilder<List<DoctorModel>>(
          future: firestoreService.getDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Ustadz found'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(snapshot.data!.length, (index) {
                    DoctorModel doctor = snapshot.data![index];
                    return SizedBox(
                      width: screenSize.width / 1.2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: defaultPadding),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => DoctorDetailsScreen(doctor: doctor));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(doctor.name,
                                          style: const TextStyle(
                                              color: textColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Text(doctor.category,
                                          style: const TextStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding / 2),
                                        child: AppRating(
                                          score: doctor.rating.toDouble(),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text("Experience",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text("${doctor.experience} years",
                                          style: const TextStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    doctor.image,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
