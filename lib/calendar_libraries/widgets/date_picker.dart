import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:provider/provider.dart';

import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event.dart';

/// simple example showing how to make a basic date range picker with
/// UI indication
class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  /// store the selected start and end dates
  DateTime? start;
  DateTime? end;

  /// method to check wether a day is in the selected range
  /// used for highlighting those day
  bool isInRange(DateTime date) {
    // if start is null, no date has been selected yet
    if (start == null) return false;
    // if only end is null only the start should be highlighted
    if (end == null) return date == start;
    // if both start and end aren't null check if date false in the range
    return ((date == start || date.isAfter(start!)) &&
        (date == end || date.isBefore(end!)));
  }

  @override
  Widget build(BuildContext context) {
    return PagedVerticalCalendar(
      addAutomaticKeepAlives: true,
      dayBuilder: (context, date) {
        // update the days color based on if it's selected or not
        final color = isInRange(date) ? Colors.green : Colors.transparent;

        return Container(
          color: color,
          child: Center(
            child: Text(DateFormat('d').format(date)),
          ),
        );
      },
      onDayPressed: (date) {
        // setState(() {
        //   // if start is null, assign this date to start
        //   if (start == null) {
        //     start = date;
        //   } else if (end == null)
        //     end = date;
        //   // if both start and end arent null, show results and reset
        //   else {
        //     print('selected range from $start to $end');
        //     start = null;
        //     end = null;
        //   }
        //   final createEvent = Event(
        //       title: '',
        //       description: '',
        //       from: DateTime.now(),
        //       to: DateTime.now());
        //   final provider = Provider.of<EventProvider>(context, listen: false);

        //   provider.addEvent(createEvent);
        // });
      },
      onPaginationCompleted: (event) {
        // final createEvent = Event(
        //     title: '',
        //     description: '',
        //     from: DateTime.now(),
        //     to: DateTime.now());
        // final provider = Provider.of<EventProvider>(context);

        // provider.addEvent(createEvent);
      },
    );
  }
}
