import 'package:doctor_appointment/app/modules/profile/components/profile_text_field.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/app_dialog.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile",
            style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/logo/logo.png')),
            const SizedBox(height: defaultPadding),
            const ProfileTextField(
                initialValue: "Miswan",
                fieldName: 'Name*',
                suffixIcon: Icons.person_outline),
            const ProfileTextField(
                initialValue: "text@gmail.com",
                fieldName: 'Email*',
                suffixIcon: Icons.mail_outline,
                readOnly: true),
            const ProfileTextField(
                initialValue: "01763551316",
                fieldName: 'Mobile*',
                suffixIcon: Icons.phone),
            const ProfileTextField(
                initialValue: "Sumenep, Madura",
                fieldName: 'Address*',
                suffixIcon: Icons.location_on_outlined),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width / 4),
              child: ElevatedButton(
                onPressed: () {
                  appDialog(
                    context,
                    const Icon(Icons.logout, size: 40, color: Colors.white),
                    'Update Profile',
                    "Are you sure update your profile?",
                    "Submit",
                    () {
                      // Define what happens on logout here
                      Navigator.of(context)
                          .pop(); // Close the dialog after performing the action
                      // Perform logout action (if needed)
                    },
                  );
                },
                child: const Text(
                  overflow: TextOverflow.ellipsis,
                  'Update Now',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
