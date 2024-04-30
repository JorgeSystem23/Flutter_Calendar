import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';
import 'package:calendar_projects/syncfusion_calendar/utils/event_data_source.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/task_widget.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    required this.calendarView,
  });

  final CalendarView calendarView;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    return SfCalendar(
      view: calendarView,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      dataSource: EventDataSource(provider.events),
      appointmentBuilder:
          (BuildContext context, CalendarAppointmentDetails details) {
        final Event event = details.appointments.first as Event;
        return Container(
          color: event.backgroundColor,
          child: Column(
            children: [
              Text(event.title),
              Text(event.advertiser),
            ],
          ),
        );
      },
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => const TaskWidget(),
        );
      },
    );
  }
}
