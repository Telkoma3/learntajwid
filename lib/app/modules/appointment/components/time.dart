import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants.dart';
import '../../../logic/controller/appointment controller/appointment_controller.dart';

class TimeWidget extends StatelessWidget {
  final List<Timestamp> availableTimes;

  TimeWidget({super.key, required this.availableTimes});

  final controller = Get.find<AppointmentController>();

  String formatTime(Timestamp time) {
    DateTime dateTime = time.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Available Times",
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: availableTimes.map((time) {
            return Obx(() => ChoiceChip(
                  label: Text(formatTime(time)),
                  selected: controller.selectedTime.value == time,
                  onSelected: (selected) {
                    if (selected) {
                      controller.selectTime(time);
                    }
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: controller.selectedTime.value == time
                        ? Colors.white
                        : Colors.black,
                  ),
                ));
          }).toList(),
        ),
      ],
    );
  }
}
