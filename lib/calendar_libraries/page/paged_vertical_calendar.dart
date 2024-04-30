import 'package:flutter/material.dart';

import 'package:calendar_projects/calendar_libraries/widgets/custom_calendar.dart';
import 'package:calendar_projects/calendar_libraries/widgets/date_picker.dart';
import 'package:calendar_projects/calendar_libraries/widgets/pagination_calendar.dart';

/// a simple example showing several ways this package can be used
/// to implement calendar related interfaces.
class WidgetCalendar extends StatelessWidget {
  const WidgetCalendar({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Paged Vertical Calendar'),
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(icon: Icon(Icons.calendar_today), text: 'Custom'),
                  Tab(icon: Icon(Icons.date_range), text: 'DatePicker'),
                  Tab(icon: Icon(Icons.dns), text: 'Pagination'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Custom(),
                DatePicker(),
                Pagination(),
              ],
            ),
          ),
        ),
      );
}
