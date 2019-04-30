import 'package:flutter/material.dart';
import 'package:whiteboard/widget/calendar_day.dart';

class CalendarMonth extends StatefulWidget {
  final num year;
  final num month;

  const CalendarMonth({Key key, this.year, this.month}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {

  @override
  Widget build(BuildContext context) => Expanded(
        child: _buildGrid(7, 6, _getDays(widget.year, widget.month)),
      );
}

Widget _buildGrid(num width, num height, Iterable<Widget> children) {
  return LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      print('${constraints.maxWidth} x ${constraints.maxHeight}');
      final aspectRatio =
          (constraints.maxWidth / width) / (constraints.maxHeight / height);
      print(aspectRatio);
      return GridView.count(
        childAspectRatio: aspectRatio,
        crossAxisCount: width,
        children: children,
      );
    },
  );
}

List<Widget> _getDays(num year, num month) {
  final days = <Widget>[];

  var firstDay = DateTime(year, month, 1);
  while (firstDay.weekday != DateTime.sunday)
    firstDay = firstDay.subtract(Duration(days: 1));

  var day = firstDay;
  for (var i = 0; i < 42; i++) {
    days.add(Container(
      child: CalendarDay(date: day),
      foregroundDecoration: day.month != month
          ? BoxDecoration(color: Colors.white.withOpacity(0.5))
          : null,
    ));
    day = day.add(Duration(days: 1));
  }

  return days;
}
