import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/appointment controller/appointment_controller.dart';

class CalendarWidget extends StatelessWidget {
  final String doctorName;
  final List<String> availableDays;

  CalendarWidget({
    super.key,
    required this.doctorName,
    required this.availableDays,
  });

  final controller = Get.find<AppointmentController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: availableDays.map((day) {
        return Obx(() => ChoiceChip(
              label: Text(day),
              selected: controller.selectedDay.value == day,
              onSelected: (selected) {
                if (selected) {
                  controller.selectDay(day);
                }
              },
            ));
      }).toList(),
    );
  }
}
