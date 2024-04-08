import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(Colors.greenAccent[400]),
        minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 50.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
