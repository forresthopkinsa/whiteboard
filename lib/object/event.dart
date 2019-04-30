import 'package:whiteboard/object/abstract_object.dart';
import 'package:whiteboard/object/category.dart';

class Event extends AbstractObject {
  DateTime date;
  String title;
  String desc;
  Category category;
  String location;

  Event(this.date, this.category, [this.title, this.desc, this.location])
      : super();
}
