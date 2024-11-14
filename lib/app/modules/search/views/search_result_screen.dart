import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../models/SearchDoctor.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/section_title.dart';
import '../../details/views/doctor_details_screen.dart';
import '../../home/components/available_doctors.dart';
import '../components/search_doctor_card.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Selected area",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Text("Boston"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/Chat.svg"),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    SectionTitle(
                      title: "All Cardiologist",
                      pressOnSeeAll: () {},
                    ),
                    ...List.generate(
                      demo_search_doctors.length,
                      (index) => SearchDoctorCard(
                          info: demo_search_doctors[index], press: () {}),
                    ),
                  ],
                ),
              ),
              AvailableDoctors(),
            ],
          ),
        ),
      ),
    );
  }
}
