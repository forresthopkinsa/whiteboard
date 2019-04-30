import 'package:scoped_model/scoped_model.dart';
import 'package:whiteboard/object/abstract_object.dart';

abstract class AbstractModel<T extends AbstractObject> extends Model {
  final List<T> _items = [];

  int compare(T a, T b);

  void _addQuietly(T item) {
    if (exists(item)) {
      throw ArgumentError('ID conflict for item: ${item.id}');
    }
    _items
      ..add(item)
      ..sort(compare);
  }

  void _removeQuietly(T item) {
    if (!exists(item)) {
      throw ArgumentError('Item to be removed does not exist: ${item.id}');
    }
    _items.removeWhere((e) => e.id == item.id);
  }

  List<T> get items => _items.toList(growable: false);

  void add(T item) {
    _addQuietly(item);
    notifyListeners();
  }

  void remove(T item) {
    _removeQuietly(item);
    notifyListeners();
  }

  void replace(T item) {
    _removeQuietly(item);
    add(item);
  }

  bool exists(T item) => _items.any((e) => e.id == item.id);

  T get(num id) => _items.firstWhere((e) => e.id == id);
}
