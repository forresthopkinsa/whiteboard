import 'package:flutter/material.dart';
import 'package:whiteboard/widget/dialog/edit_dialog.dart';

class EditTextDialog extends StatefulWidget {
  final String title;
  final String label;

  const EditTextDialog({Key key, @required this.title, @required this.label}) : super(key: key);

  @override
  _EditTextDialogState createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<EditTextDialog> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      title: widget.title,
      getValue: () => _controller.text,
      content: TextField(
        decoration: InputDecoration(
          labelText: widget.label,
          icon: Icon(Icons.text_fields),
        ),
        controller: _controller,
        autofocus: true,
      ),
    );
  }
}
