import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/model/event_model.dart';
import 'package:whiteboard/widget/calendar_event.dart';
import 'package:whiteboard/widget/route/day_route.dart';

class CalendarDay extends StatefulWidget {
  final DateTime date;

  const CalendarDay({Key key, this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  @override
  Widget build(BuildContext context) {
    final date = widget.date;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DayRoute(date: date)));
      },
      child: Card(
          margin: EdgeInsets.all(1),
          child: ScopedModelDescendant<CategoryModel>(
            builder: (context, child, categoryModel) =>
                ScopedModelDescendant<EventModel>(
                  builder: (context, child, eventModel) {
                    eventModel.refresh(categoryModel);
                    return Wrap(children: [
                      _getDayLabel(date.day),
                      ...eventModel
                          .getEventsForDay(date)
                          .map((e) => CalendarEvent(event: e))
                    ]);
                  },
                ),
          ),
          color: _isEvenWeekday(date.weekday)
              ? Colors.white
              : Colors.white.withOpacity(0.85)),
    );
  }
}

bool _isEvenWeekday(int weekday) =>
    [DateTime.monday, DateTime.wednesday, DateTime.friday].contains(weekday);

Widget _getDayLabel(num day) => Center(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(
            day.toString(),
            textScaleFactor: 0.75,
          )),
    );
