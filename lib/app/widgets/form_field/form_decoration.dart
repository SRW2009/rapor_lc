
import 'package:flutter/material.dart';


final inputDecoration = InputDecoration(
  filled: true,
  isCollapsed: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.all(16.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(.20),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(.20),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: const Color.fromRGBO(3, 103, 166, 1.0).withOpacity(.6),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red.withOpacity(.50),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red.withOpacity(.50),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
);