import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:whiteboard/widget/dialog/edit_dialog.dart';

class EditColorDialog extends StatefulWidget {
  final String title;
  final Color oldColor;

  const EditColorDialog({Key key, this.title, this.oldColor}) : super(key: key);

  @override
  _EditColorDialogState createState() => _EditColorDialogState();
}

class _EditColorDialogState extends State<EditColorDialog> {
  Color color;

  @override
  void initState() {
    super.initState();
    color = widget.oldColor;
  }

  @override
  Widget build(BuildContext context) => EditDialog(
        title: widget.title,
        getValue: () => color,
        content: SingleChildScrollView(
            child: BlockPicker(
          pickerColor: color,
          onColorChanged: (newColor) => setState(() {
                color = newColor;
              }),
        )),
      );
}
