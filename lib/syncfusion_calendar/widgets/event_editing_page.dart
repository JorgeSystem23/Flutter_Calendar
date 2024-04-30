import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';
import 'package:calendar_projects/syncfusion_calendar/utils/utils.dart';
import 'package:calendar_projects/syncfusion_calendar/widgets/event.dart';

class EventEditingPage extends StatefulWidget {
  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  final Event? event;

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final advertiserController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = fromDate.add(const Duration(hours: 2));
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      advertiserController.text = event.advertiser;
      fromDate = event.from;
      toDate = event.to;
      isActive = event.isActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text('Crear o Editar Evento'),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              buildAdvertiser(),
              buildDateTimePicker(),
              buildActiveSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          onPressed: saveForm,
          icon: const Icon(Icons.done),
          label: const Text('GUARDAR'),
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
        ),
      ];

  Widget buildTitle() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            labelText: 'Título',
          ),
          controller: titleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, ingrese un título';
            }
            return null;
          },
        ),
      );

  Widget buildAdvertiser() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            labelText: 'Anunciante',
          ),
          controller: advertiserController,
        ),
      );

  Widget buildDateTimePicker() => Column(
        children: [
          buildForm(),
          buildTo(),
        ],
      );

  Widget buildForm() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Widget buildTo() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildActiveSwitch() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text('Activo'),
            Switch(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),
          ],
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      fromDate,
      pickDate: pickDate,
    );
    if (date != null) {
      if (date.isAfter(toDate)) {
        toDate = DateTime(
          date.year,
          date.month,
          date.day,
          toDate.hour,
          toDate.minute,
        );
      }
      setState(() => fromDate = date);
    }
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date != null) {
      setState(() => toDate = date);
    }
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (timeOfDay == null) return null;

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2021, 8),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    final pickedDate = DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    return pickedDate;
  }

  void saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final event = Event(
      title: titleController.text,
      description: 'Description',
      from: fromDate,
      to: toDate,
      isAllDay: false,
      advertiser: advertiserController.text,
      isActive: isActive,
      duration: toDate.difference(fromDate),
    );

    final isEditing = widget.event != null;
    final provider = Provider.of<EventProvider>(context, listen: false);

    if (isEditing) {
      provider.editEvent(event, widget.event!);
    } else {
      provider.addEvent(event);
    }

    Navigator.of(context).pop();
  }
}
