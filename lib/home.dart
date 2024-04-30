import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:calendar_projects/calendar_libraries/page/paged_vertical_calendar.dart';
import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';
import 'package:calendar_projects/syncfusion_calendar/page/syncfusion_flutter_calendar.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event_editing_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.today),
                onPressed: () => provider.setCalendarView(CalendarView.day),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_view_week),
                onPressed: () => provider.setCalendarView(CalendarView.week),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => provider.setCalendarView(CalendarView.month),
              ),
            ],
          ),
        ],
      ),
      body:
          // const WidgetCalendar(),
          CalendarWidget(
        calendarView: provider.calendarView,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EventEditingPage(),
          ),
        ),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }
}
