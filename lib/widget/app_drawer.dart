import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/object/category.dart';
import 'package:whiteboard/widget/dialog/edit_color_dialog.dart';
import 'package:whiteboard/widget/dialog/edit_text_dialog.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: ScopedModelDescendant<CategoryModel>(
      builder: (context, child, categoryModel) {
        return ListView(padding: const EdgeInsets.all(0.0), children: <Widget>[
          Container(
            height: 128,
            child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: Colors.white),
                        text: 'Whiteboard '),
                    TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: Colors.white, fontWeightDelta: -2),
                        text: 'Calendar')
                  ]),
                )),
          ),
          ListTile(
            title: Text('Categories'),
          ),
          ...categoryModel.items.map((category) => ListTile(
              leading: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: category.color,
                  radius: 12,
                ),
                onTap: () async {
                  final newColor = await showDialog<Color>(
                      context: context,
                      builder: (context) => EditColorDialog(
                            title: 'Edit Category Color',
                            oldColor: category.color,
                          ));
                  if (newColor != null)
                    categoryModel.replace(category..color = newColor);
                },
              ),
              title: Text(category.name),
              onTap: () async {
                final newName = await showDialog<String>(
                    context: context,
                    builder: (context) => EditTextDialog(
                        title: 'Edit Category Name', label: 'New name'));
                if (newName != null)
                  categoryModel.replace(category..name = newName);
              })),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add new category'),
            onTap: () {
              categoryModel.add(Category('Untitled'));
            },
          )
        ]);
      },
    ));
  }
}
