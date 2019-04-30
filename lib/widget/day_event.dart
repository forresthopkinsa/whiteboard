import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whiteboard/object/event.dart';

class DayEvent extends StatelessWidget {
  final Event event;
  final void Function() onTap;

  const DayEvent({Key key, this.event, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
    elevation: 4.0,
        child: ListTile(
          leading: event.category.avatar,
          title: Text(event.title),
          subtitle: Text(_timeFormatter.format(event.date)),
          onTap: onTap,
        ),
      );
}

final _timeFormatter = DateFormat.jm();
