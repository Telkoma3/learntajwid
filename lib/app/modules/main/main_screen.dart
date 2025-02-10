import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../utils/constants.dart';
import '../../logic/controller/main controller/main_screen_controller.dart';
import '../appointment/views/my_appointment_screen.dart';
import '../doctors/views/doctors_screen.dart';
import '../home/views/home_screen.dart';
import '../profile/views/profile_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final controller = Get.put(MainController());

  final List pages = [
    const HomePage(),
    DoctorsScreen(),
    const MyAppointmentScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => pages[controller.selectedPage.value]),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(defaultPadding),
            color: Colors.white,
            child: SafeArea(
                child: GNav(
                    haptic: true,
                    tabBorderRadius: 15,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 350),
                    gap: 8,
                    color: Colors.grey[800],
                    activeColor: Colors.white,
                    iconSize: 24,
                    tabBackgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15 / 2),
                    tabs: const [
                      GButton(icon: Icons.home, text: 'Home'),
                      GButton(icon: Icons.people, text: 'Ustadz'),
                      GButton(icon: Icons.content_paste, text: 'Appointment'),
                      GButton(icon: Icons.person, text: 'Profile')
                    ],
                    onTabChange: (index) {
                      controller.onTabChange(index);
                    }))));
  }
}
