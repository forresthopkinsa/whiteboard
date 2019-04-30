import 'package:flutter/material.dart';

class EditDialog<T> extends StatelessWidget {
  final String title;
  final Widget content;
  final T Function() getValue;

  const EditDialog({Key key, this.title, this.content, this.getValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
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
            Navigator.of(context).pop<T>(getValue());
          },
        )
      ],
    );
  }
}
