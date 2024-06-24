// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/widget/reuseable_text.dart';
import 'package:flutter/material.dart';

class ReUseAbleCartForRow extends StatelessWidget {
  const ReUseAbleCartForRow({
    super.key,
    required this.text,
    required this.price,
  });
  final String text;
  final double price;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: textTheme.headlineSmall?.copyWith(color: Colors.grey, fontSize: 16),
          ),
          ReUseableTextForDetails(
            text: price.toString(),
          )
        ],
      ),
    );
  }
}
