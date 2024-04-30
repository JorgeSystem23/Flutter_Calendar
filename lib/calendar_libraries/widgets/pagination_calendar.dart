import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

import 'package:calendar_projects/syncfusion_calendar/widgets/task_widget.dart';

/// simple example on how to display paginated data in the calendar and interact
/// with it.
class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  PaginationState createState() => PaginationState();
}

class PaginationState extends State<Pagination> {
  /// list holding all the items we are displaying
  List<DateTime> items = [];

  /// called every time a new month is loaded
  void fetchNewEvents(int year, int month) async {
    Random random = Random();
    // this is where you would load your custom data, sync or async
    // this data does require a date so you can later filter on that
    // date
    final newItems = List<DateTime>.generate(random.nextInt(40), (i) {
      return DateTime(year, month, random.nextInt(27) + 1);
    });

    // add to all our fetched items and update UI
    setState(() => items.addAll(newItems));
  }

  @override
  Widget build(BuildContext context) {
    return PagedVerticalCalendar(
      // to prevent the data from being reset every time a user loads or
      // unloads this widget
      addAutomaticKeepAlives: true,
      // when the new month callback fires, we want to fetch the items
      // for this month
      onMonthLoaded: fetchNewEvents,
      dayBuilder: (context, date) {
        // from all our items get those that are supposed to be displayed
        // on this day
        final eventsThisDay = items.where((e) => e == date);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('d').format(date)),
            // for every event this day, add a small indicator dot
            Wrap(
              children: eventsThisDay.map((event) {
                return const Padding(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.red,
                  ),
                );
              }).toList(),
            )
          ],
        );
      },
      onDayPressed: (day) {
        // when a day is pressed we can check which events are linked to this
        // day and do something with them. e.g. open a new page
        final eventsThisDay = items.where((e) => e == day);
        showModalBottomSheet(
          context: context,
          builder: (context) => const TaskWidget(),
        );
        print('items this day: $eventsThisDay');
      },
    );
  }
}
