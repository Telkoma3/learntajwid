import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../style/toast_style.dart';

class AppointmentController extends GetxController {
  var selectedDay = ''.obs;
  var doctorCategory = ''.obs;
  var zoomLink = ''.obs;
  var selectedTime = Rx<Timestamp?>(null); // 🔥 Perbaiki inisialisasi menjadi `null`

  RxString name = ''.obs;
  RxString number = ''.obs;
  RxString problem = ''.obs;

  @override
  void onInit() {
    super.onInit();
    doctorCategory.value = "";
    zoomLink.value = "Coming soon";
  }

  void selectDay(String day) {
    selectedDay.value = day;
  }

  void selectTime(Timestamp time) {
    selectedTime.value = time;
  }

  void setDoctorCategory(String category) {
    doctorCategory.value = category;
  }

  void setZoomLink(String link) {
    zoomLink.value = link;
  }

  Future<void> saveAppointment(String doctorName) async {
    if (selectedDay.value.isEmpty || selectedTime.value == null) {
      errorToast('Please select both day and time.');
      return;
    }
    if (name.value.isEmpty || number.value.isEmpty || problem.value.isEmpty) {
      errorToast('All fields are required.');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('appointments').add({
        'doctor_name': doctorName,
        'type': doctorCategory.value,
        'selected_day': selectedDay.value,
        'selected_time': selectedTime.value,
        'problem': problem.value,
        'zoom_link': zoomLink.value,
        'patientName': name.value,
        'contactNumber': number.value,
        'timestamp': FieldValue.serverTimestamp(),
      });
      successToast('Appointment confirmed successfully!');
    } catch (e) {
      errorToast('Failed to confirm appointment: $e');
    }
  }
}
