// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';

class DatePickerFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(DateTime) onDateSelected;

  const DatePickerFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 1825)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
        widget.onDateSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: IgnorePointer(
        child: TextFormField(
          controller: widget.controller,
          cursorColor: primaryColor,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: accentColor,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Color(0xFF585656)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: primaryColor,
              ),
            ),
            prefixIcon: const Icon(
              IconlyBold.calendar,
              color: primaryColor,
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
