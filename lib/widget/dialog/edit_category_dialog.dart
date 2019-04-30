import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/object/category.dart';
import 'package:whiteboard/widget/dialog/edit_dialog.dart';

class EditCategoryDialog extends StatefulWidget {
  final Category oldCategory;

  const EditCategoryDialog({Key key, this.oldCategory}) : super(key: key);

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  Category newCategory;

  @override
  void initState() {
    super.initState();
    newCategory = widget.oldCategory;
  }

  @override
  Widget build(BuildContext context) => EditDialog(
        title: 'Edit Event Category',
        getValue: () => newCategory,
        content: Container(
          width: double.maxFinite,
          child: ScopedModelDescendant<CategoryModel>(
            builder: (context, child, categoryModel) => ListView(
                  children: categoryModel.items
                      .map((category) => ListTile( // todo: replace with RadioListTile
                            leading: category.avatar,
                            trailing: Icon(category.same(newCategory)
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked),
                            title: Text(category.name),
                            selected: category.same(newCategory),
                            onTap: () {
                              setState(() {
                                newCategory = category;
                              });
                            },
                          ))
                      .toList(),
                ),
          ),
        ),
      );
}
