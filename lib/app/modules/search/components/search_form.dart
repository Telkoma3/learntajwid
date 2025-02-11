import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/constants.dart';
import '../views/search_result_screen.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropdownMenu(
            width: double.infinity,
            hintText: "Select Area",
            trailingIcon: SvgPicture.asset("assets/icons/address.svg"),
            dropdownMenuEntries:
                doctorAreas.map<DropdownMenuEntry<String>>((String area) {
              return DropdownMenuEntry(
                value: area,
                label: area,
              );
            }).toList(),
            onSelected: (value) {},
          ),
          const SizedBox(height: defaultPadding),
          DropdownMenu(
            width: double.infinity,
            hintText: "Select Capabilities",
            trailingIcon: SvgPicture.asset("assets/icons/stethoscope.svg"),
            dropdownMenuEntries: doctorSpecialists
                .map<DropdownMenuEntry<String>>((String specialist) {
              return DropdownMenuEntry(
                value: specialist,
                label: specialist,
              );
            }).toList(),
            onSelected: (value) {},
          ),
          const SizedBox(height: defaultPadding),
          MaterialButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );
            },
            color: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: defaultPadding * 1.25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date",
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 15,
                  ),
                ),
                SvgPicture.asset("assets/icons/event.svg")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchResultScreen(),
                ),
              ),
              child: const Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> doctorSpecialists = [
  "Cardiologist",
  "Dermatologist",
  "Pediatrician",
  "Neurologist",
  "Orthopedic Surgeon",
  "Ophthalmologist",
  "Psychiatrist",
  "Gastroenterologist",
  "Radiologist",
  "Endocrinologist",
];

List<String> doctorAreas = [
  "Cardiology",
  "Dermatology",
  "Pediatrics",
  "Neurology",
  "Orthopedics",
  "Ophthalmology",
  "Psychiatry",
  "Gastroenterology",
  "Radiology",
  "Endocrinology",
];
