import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/dummySuggestData.dart';
import '../../../../utils/constants.dart';
import '../../details/views/doctor_details_screen.dart';

class RecommendDoctorCard extends StatelessWidget {
  const RecommendDoctorCard({
    super.key,
    required this.doctor,
  });

  final DummySuggestData doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Find the Ustadz Can Teach you ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.limeAccent,
                          fontWeight: FontWeight.w700)),
                  Row(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(right: defaultPadding / 2),
                        width: 2,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Color(0xFF83D047),
                          borderRadius:
                              BorderRadius.all(Radius.circular(defaultPadding)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "${doctor.speciality}\n${doctor.institute}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(doctor.image),
            ),
          ],
        ),
      ),
    );
  }
}
