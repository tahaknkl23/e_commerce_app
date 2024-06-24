import 'package:e_commerce_app/main_wrapper.dart';
import 'package:e_commerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.appTheme,
    home: const MainWrapper(),
  ));
}
