import 'package:flutter/material.dart';

Widget detailsDialog(
    {required String title,
    required String subtitle,
    required BuildContext context}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black),
          subtitleTextStyle: const TextStyle(fontSize: 24, color: Colors.black),
          title: Text(title),
          subtitle: Text('\n$subtitle'),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xff000000)),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    ),
  );
}
