import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/model/event_model.dart';
import 'package:whiteboard/object/category.dart';
import 'package:whiteboard/widget/calendar_month.dart';
import 'package:whiteboard/widget/dialog/edit_color_dialog.dart';
import 'package:whiteboard/widget/dialog/edit_text_dialog.dart';

void main() {
  runApp(WhiteboardApp());
}

class WhiteboardApp extends StatelessWidget {
  final EventModel _eventModel = EventModel();
  final CategoryModel _categoryModel = CategoryModel();

  WhiteboardApp() {
    _categoryModel.add(Category('main', Colors.amber));
  }

  @override
  Widget build(BuildContext context) => ScopedModel<EventModel>(
      model: _eventModel,
      child: ScopedModel<CategoryModel>(
        model: _categoryModel,
        child: MaterialApp(
          title: 'Welcome to Flutter',
          home: RandomWords(),
          theme: ThemeData(
              primarySwatch: Colors.red,
              primaryColor: Colors.pink.shade900,
              accentColor: Colors.amber),
        ),
      ));
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('April'),
        ),
        drawer: Drawer(child: ScopedModelDescendant<CategoryModel>(
          builder: (context, child, categoryModel) {
            return ListView(padding: const EdgeInsets.all(0.0), children: <
                Widget>[
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
                            style: Theme.of(context).textTheme.title.apply(
                                color: Colors.white, fontWeightDelta: -2),
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
                          builder: (context) =>
                              EditColorDialog(title: 'Edit Category Color', oldColor: category.color,));
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
        )),
        body: Container(
          child: Column(
            children: [
              DefaultTextStyle(
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                      .map((s) => Text(s))
                      .toList(),
                ),
              ),
              CalendarMonth(
                  year: DateTime.now().year, month: DateTime.now().month)
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          padding: EdgeInsets.all(4),
        ),
      );
}
