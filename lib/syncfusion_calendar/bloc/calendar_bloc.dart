import 'package:flutter/cupertino.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:calendar_projects/syncfusion_calendar/widgets/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  CalendarView _calendarView = CalendarView.month;

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
    notifyListeners();
  }

   CalendarView get calendarView => _calendarView;

  void setCalendarView(CalendarView view) {
    _calendarView = view;
    notifyListeners();
  }
}
