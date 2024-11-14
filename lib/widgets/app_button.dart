import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.text, this.ontap});
  final String? text;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFF9A825),
      ),
      child: Text(text ?? ''),
    );
  }
}
