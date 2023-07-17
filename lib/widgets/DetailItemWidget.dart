import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final String title;
  final String value;
  const DetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[900],
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
