import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/app_dialog.dart';
import '../../../../widgets/app_rating.dart';
import '../../../../widgets/heightlight.dart';
import '../../../logic/model/doctor_model.dart';
import '../../appointment/views/appointment_screen.dart';
import '../components/contact_button.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  ///Call Now
  void callNow(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not launch dialer");
    }
  }

  void openWhatsapp(String number, String message) async {
    final Uri uri = Uri.parse("https://wa.me/$number?text=$message");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not launch WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor.name,
          style: const TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(doctor.image, fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: ContactButton(
                  callOntap: () {
                    appDialog(
                      context,
                      const Icon(Icons.phone),
                      'Open Dial App?',
                      "Do you want to call ${doctor.name}?",
                      "Call Now",
                      () {
                        callNow("0 ${doctor.mobile.toString()}");
                      },
                    );
                  },
                  messageOntap: () {
                    appDialog(
                      context,
                      const Icon(Icons.message),
                      'Open Whatsapp? ',
                      "Do you want to send a message to ${doctor.name}?",
                      "Message Now",
                      () {
                        openWhatsapp(
                            doctor.mobile.toString(), "Hello ${doctor.name}");
                      },
                    );
                  },
                ),
              ),

              /// Specialization
              Text(
                doctor.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              /// Clinic Name
              Text(
                doctor.institute,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /// Rating
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                child: AppRating(score: doctor.rating.toDouble()),
              ),
              const SizedBox(height: 15),

              /// About
              Text(
                "About Ustadz ${doctor.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Text(doctor.about),
              ),

              /// Highlights
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Highlight(
                      name: "Leaner",
                      text: doctor.parients,
                    ),
                    Highlight(
                        name: "Experience", text: "${doctor.experience} Years"),
                    Highlight(
                      name: "Reviews",
                      text: doctor.reviews,
                    ),
                  ],
                ),
              ),

              /// Book Appointment Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => AppointmentScreen(doctor: doctor)), // Pass doctor data
                  child: const Text("Book an Appointment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
