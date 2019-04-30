import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/model/event_model.dart';
import 'package:whiteboard/object/event.dart';
import 'package:whiteboard/widget/day_event.dart';
import 'package:whiteboard/widget/route/event_route.dart';

final _dateFormatter = DateFormat.yMMMd();

class DayRoute extends StatefulWidget {
  final DateTime date;

  const DayRoute({Key key, this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DayRouteState();
}

class _DayRouteState extends State<DayRoute> {
  @override
  Widget build(BuildContext context) => ScopedModelDescendant<EventModel>(
      builder: (context, child, eventModel) =>
          ScopedModelDescendant<CategoryModel>(
            builder: (context, child, categoryModel) => Scaffold(
                  appBar: AppBar(
                    title: Text(_dateFormatter.format(widget.date)),
                  ),
                  body: Container(
                    child: ListView(
                      children: eventModel
                          .getEventsForDay(widget.date)
                          .map((event) => DayEvent(
                                event: event,
                                onTap: () async {
                                  final newEvent = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => EventRoute(
                                                event: event,
                                              )));
                                  if (newEvent != null) {
                                    eventModel.replace(newEvent);
                                  }
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      final newEvent = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EventRoute(
                                  event: Event(
                                      widget.date, categoryModel.items[0]))));
                      if (newEvent != null) {
                        eventModel.add(newEvent);
                      }
                    },
                  ),
                ),
          ));
}
