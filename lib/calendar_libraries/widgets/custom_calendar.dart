import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

/// simple demonstration of the calendar customizability
class Custom extends StatelessWidget {
  const Custom({super.key});

  @override
  Widget build(BuildContext context) {
    return PagedVerticalCalendar(
      startWeekWithSunday: true,

      /// customize the month header look by adding a week indicator
      monthBuilder: (context, month, year) {
        return Column(
          children: [
            /// create a customized header displaying the month and year
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: Text(
                DateFormat('MMMM yyyy').format(DateTime(year, month)),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),

            /// add a row showing the weekdays
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weekText('Su'),
                  weekText('Mo'),
                  weekText('Tu'),
                  weekText('We'),
                  weekText('Th'),
                  weekText('Fr'),
                  weekText('Sa'),
                ],
              ),
            ),
          ],
        );
      },

      /// added a line between every week
      dayBuilder: (context, date) {
        return Column(
          children: [
            Text(DateFormat('d').format(date)),
            const Divider(),
          ],
        );
      },
    );
  }

  Widget weekText(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      ),
    );
  }
}
