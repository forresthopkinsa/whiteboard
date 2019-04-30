import 'package:flutter/material.dart';
import 'package:whiteboard/object/event.dart';

class CalendarEvent extends StatefulWidget {
  final Event event;

  const CalendarEvent({Key key, this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  @override
  Widget build(BuildContext context) =>
      Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          padding: EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.event.category.color,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            widget.event.title,
            textScaleFactor: 0.75,
            style: TextStyle(color: Colors.white),
          ));
}
