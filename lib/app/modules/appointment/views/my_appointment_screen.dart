import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/constants.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Appointment"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('appointments').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No Appointments Found"));
              }

              var appointments = snapshot.data!.docs;

              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  var appointment = appointments[index];

                  // Ambil data dari Firestore
                  var day = appointment['selected_day'] ?? "Unknown Day"; // Langsung String
                  
                  // Konversi Timestamp ke String
                  Timestamp? timeStamp = appointment['selected_time'];
                  var time = timeStamp != null
                      ? "${timeStamp.toDate().hour}:${timeStamp.toDate().minute} ${timeStamp.toDate().hour >= 12 ? 'PM' : 'AM'}"
                      : "Unknown Time";

                  var ustadz = appointment['doctor_name'] ?? "Unknown Ustadz";
                  var type = appointment['type'] ?? "Unknown Type";
                  var zoomLink = appointment['zoom_link'] ?? "Coming soon";

                  return Container(
                    margin: const EdgeInsets.only(bottom: defaultPadding),
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 2)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: buildAppointmentInfo("Day", day),
                            ),
                            Expanded(
                              child: buildAppointmentInfo("Time", time),
                            ),
                            Expanded(
                              child: buildAppointmentInfo("Ustadz", ustadz),
                            ),
                          ],
                        ),
                        const Divider(height: defaultPadding * 2),
                        Row(
                          children: [
                            Expanded(
                              child: buildAppointmentInfo("Type", type),
                            ),
                            Expanded(
                              child: buildAppointmentInfo("Link Zoom", zoomLink),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance.collection('appointments').doc(appointment.id).delete();
                                },
                                style: TextButton.styleFrom(backgroundColor: redColor),
                                child: const Text("Cancel"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Column buildAppointmentInfo(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withOpacity(0.62),
          ),
        ),
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
