import 'package:whiteboard/model/abstract_model.dart';
import 'package:whiteboard/model/category_model.dart';
import 'package:whiteboard/object/event.dart';

class EventModel extends AbstractModel<Event> {
  @override
  int compare(Event a, Event b) => a.date.compareTo(b.date);

  List<Event> getEventsForDay(DateTime day) => items
      .where((e) => _despecify(e.date).isAtSameMomentAs(_despecify(day)))
      .toList(growable: false);

  void refresh(CategoryModel categoryModel) => items.forEach((event) {
        event.category = categoryModel.get(event.category.id);
      });
}

DateTime _despecify(DateTime date) => DateTime(date.year, date.month, date.day);
