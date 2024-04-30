// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Meeting {
  Meeting(
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  );
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
