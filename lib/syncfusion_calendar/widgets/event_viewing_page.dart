import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event_editing_page.dart';

class EventViewingPage extends StatelessWidget {
  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildViewingActions(context, event),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${event.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Descripción: ${event.description}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Anunciante: ${event.advertiser}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Estado: ${event.isActive ? "Activo" : "Inactivo"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Duración: ${event.duration.inHours} horas',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventEditingPage(
              event: event,
            ),
          ),
        ),
        icon: const Icon(Icons.edit),
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          final provider = Provider.of<EventProvider>(context);
          provider.deleteEvent(event);
          Navigator.of(context).pop();
        },
      ),
    ];
  }
}
