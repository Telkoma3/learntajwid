import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/app/modules/main/main_screen.dart';
import 'package:doctor_appointment/style/toast_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  ///Instance...
  final auth = FirebaseAuth.instance;
  final users = FirebaseAuth.instance.currentUser;

  register() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.value, password: password.value)
          .then((value) {
        if (value.user != null) {
          Get.offAll(MainScreen());
          successToast('Successfully Signup');
        }
      });

      ///Profile info collect...
      Map<String, dynamic> userInfo = {
        "phone": phone.value,
        "email": email.value,
        "userName": email.value.replaceAll("@gmail.com", ""),
        "photos": "",
        "address": "",
        "gender": ""
      };
      await FirebaseFirestore.instance.collection("users").add(userInfo);

      ///Auth Exception...
    } on FirebaseAuthException catch (error) {
      errorToast(error);
    }
  }
}
