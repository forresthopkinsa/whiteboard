import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whiteboard/object/category.dart';
import 'package:whiteboard/object/event.dart';
import 'package:whiteboard/widget/dialog/edit_category_dialog.dart';
import 'package:whiteboard/widget/dialog/edit_text_dialog.dart';

class EventRoute extends StatefulWidget {
  final Event event;

  const EventRoute({Key key, this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventRouteState(event);
}

class _EventRouteState extends State<EventRoute> {
  final Event event;

  _EventRouteState(this.event);

  @override
  void initState() {
    super.initState();
    event.title = event.title ?? 'Untitled';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(event.title),
          actions: [
            IconButton(
                onPressed: () async {
                  var newTitle = await showDialog(
                      context: context,
                      builder: (context) => EditTextDialog(
                          title: 'Edit Event Title', label: 'New title'));
                  if (newTitle != null) {
                    setState(() {
                      event.title = newTitle;
                    });
                  }
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.today),
              title: Text(_dateFormatter.format(event.date)),
              subtitle: Text('Date'),
              onTap: () async {
                final newDate = await showDatePicker(
                    context: context,
                    initialDate: event.date,
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2029));
                final oldDate = event.date;
                setState(() {
                  event.date = DateTime(newDate.year, newDate.month,
                      newDate.day, oldDate.hour, oldDate.minute);
                });
                print(event.date);
              },
            ),
            ListTile(
                leading: Icon(Icons.access_time),
                title: Text(_timeFormatter.format(event.date)),
                subtitle: Text('Time'),
                onTap: () async {
                  final newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(event.date));
                  final oldDate = event.date;
                  setState(() {
                    event.date = DateTime(oldDate.year, oldDate.month,
                        oldDate.day, newTime.hour, newTime.minute);
                  });
                  print(event.date);
                }),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(event.category.name),
              subtitle: Text('Category'),
              onTap: () async {
                final newCategory = await showDialog<Category>(
                    context: context,
                    builder: (context) => EditCategoryDialog(
                          oldCategory: event.category,
                        ));
                if (newCategory != null)
                  setState(() {
                    event.category = newCategory;
                  });
              },
            ),
            ListTile(
                leading: Icon(Icons.edit_location), title: Text('Location')),
            ListTile(leading: Icon(Icons.comment), title: Text('Note')),
          ],
        ),
        persistentFooterButtons: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            textTheme: ButtonTextTheme.normal,
          ),
          FlatButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(event);
              }),
        ],
      );
}

final _dateFormatter = DateFormat.yMMMd();
final _timeFormatter = DateFormat.jm();
