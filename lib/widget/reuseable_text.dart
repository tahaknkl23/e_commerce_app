import 'package:e_commerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ReUseableTextForDetails extends StatelessWidget {
  const ReUseableTextForDetails({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: "€ ",
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: primaryColor,
        ),
        children: [
          TextSpan(
            text: text,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
