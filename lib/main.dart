import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/model/event_model.dart';
import 'package:whiteboard/object/category.dart';
import 'package:whiteboard/widget/route/home_route.dart';

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
          title: 'Whiteboard App',
          home: HomeRoute(),
          theme: ThemeData(
              primarySwatch: Colors.red,
              primaryColor: Colors.pink.shade900,
              accentColor: Colors.amber),
        ),
      ));
}
