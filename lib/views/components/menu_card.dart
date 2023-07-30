import 'package:app/views/components/default_button.dart';
import 'package:flutter/material.dart';

Widget menuCard({
  required Color color,
  required String image,
  required VoidCallback onTap,
  required String label,
  String buttonLabel = 'Go There',
  Color textColor = Colors.black,
  double height = 100,
  double width = 150,
}) {
  return Row(
    children: [
      Column(
        children: [
          Image.asset(
            image,
            width: width,
            height: height,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
          child: defaultButton(onTap: onTap, text: buttonLabel, color: color))
    ],
  );
}
