
// ignore_for_file: must_be_immutable, library_prefixes, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as GradientWidgets;



class ProgressDialog extends StatelessWidget {
  final String status;

  ProgressDialog({required this.status});

  Gradient g1 = const LinearGradient(
    colors: [
      Colors.red,
      Colors.green,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              GradientWidgets.GradientCircularProgressIndicator(
                valueGradient: g1,
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                status,
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}