// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget {
  final Widget Function(BuildContext context, DateTime day)? dowBuilder;
  final Widget Function(BuildContext context, DateTime day) dayBuilder;
  final List<DateTime> visibleDays;
  final Decoration? dowDecoration;
  final Decoration? rowDecoration;
  final bool dowVisible;
  final bool hideWeekends;
  final List<int> weekendDays;

  const CalendarPage({
    Key? key,
    required this.visibleDays,
    this.dowBuilder,
    required this.dayBuilder,
    this.dowDecoration,
    this.rowDecoration,
    this.dowVisible = true,
    required this.hideWeekends,
    required this.weekendDays,
  })   : assert(!dowVisible || dowBuilder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        if (dowVisible) _buildDaysOfWeek(context),
        ..._buildCalendarDays(context),
      ],
    );
  }

  TableRow _buildDaysOfWeek(BuildContext context) {
    List<Widget> dows = [];
    for (int i = 1; i < 7; i++) {
      if (hideWeekends) {
        if (!weekendDays.contains(i)) {
          dows.add(dowBuilder!(context, visibleDays[i]));
        }
      } else {
        dows.add(dowBuilder!(context, visibleDays[i]));
      }
    }
    return TableRow(
      decoration: dowDecoration,
      children: dows,
    );
  }

  List<TableRow> _buildCalendarDays(BuildContext context) {
    final rowAmount = visibleDays.length ~/ 7;

    return List.generate(rowAmount, (index) => index * 7).map((index) {
      List<Widget> cells = [];
      for (int i = 1; i < 7; i++) {
        if (hideWeekends) {
          if (!weekendDays.contains(i)) {
            cells.add(dayBuilder(context, visibleDays[index + i]));
          }
        } else {
          cells.add(dayBuilder(context, visibleDays[index + i]));
        }
      }
      return TableRow(
        decoration: rowDecoration,
        children: cells,
      );
    }).toList();
  }
}
