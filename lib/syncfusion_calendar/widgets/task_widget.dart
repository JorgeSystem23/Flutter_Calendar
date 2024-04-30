import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';
import 'package:calendar_projects/syncfusion_calendar/utils/event_data_source.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event_viewing_page.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectEvents = provider.eventsOfSelectedDate;
    if (selectEvents.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron eventos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      );
    }
    return SfCalendar(
      headerStyle: const CalendarHeaderStyle(
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      todayHighlightColor: Colors.white,
      headerHeight: 5,
      selectionDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialDisplayDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      onTap: (details) {
        if (details.appointments == null) return;

        final event = details.appointments!.first as Event;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event),
          ),
        );
      },
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first as Event;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event),
          ),
        );
      },
      child: Container(
        width: details.bounds.width,
        height: details.bounds.height,
        decoration: BoxDecoration(
          color: event.isActive
              ? Colors.green.withOpacity(0.5)
              : Colors.red.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            event.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
