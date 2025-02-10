
import 'package:doctor_appointment/app/logic/controller/appointment%20controller/appointment_controller.dart';
import 'package:doctor_appointment/app/modules/main/main_screen.dart';
import 'package:doctor_appointment/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../logic/model/doctor_model.dart';
import '../../profile/components/profile_text_field.dart';
import '../components/calendar.dart';
import '../components/time.dart';

class AppointmentScreen extends StatelessWidget {
  final DoctorModel doctor;
  AppointmentScreen({super.key, required this.doctor}){
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1970958431.
     Get.lazyPut(() => AppointmentController()); // Inisialisasi di sini
  }

  final controller = Get.find<AppointmentController>(); // 🔥 Gunakan Get.find agar tidak duplikat

  @override
  Widget build(BuildContext context) {
    controller.setDoctorCategory(doctor.category);
    controller.setZoomLink("Coming soon");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Appointment",
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: [
            Text(
              doctor.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text(doctor.category,
                style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),

            CalendarWidget(availableDays: doctor.days, doctorName: doctor.name),
            TimeWidget(availableTimes: doctor.time),

            const SizedBox(height: 20),

            ProfileTextField(
              fieldName: 'Learner Name*',
              onChanged: (value) => controller.name.value = value,
            ),
            ProfileTextField(
              fieldName: 'Contact Number*',
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.number.value = value,
            ),
            ProfileTextField(
              fieldName: 'Tell us your goal Learn Tajwid*',
              maxLine: 5,
              onChanged: (value) => controller.problem.value = value,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text("Confirm Appointment"),
                onPressed: () {
                  controller.saveAppointment(doctor.name).then((_) {
                    appDialog(
                        context,
                        Image.asset('assets/icons/success.png', height: 40),
                        "Appointment Confirmed",
                        "Your appointment has been confirmed. You will be contacted very soon.",
                        "Go Home", () {
                      Get.offAll(() => MainScreen());
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
