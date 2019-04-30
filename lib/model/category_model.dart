import 'package:whiteboard/model/abstract_model.dart';
import 'package:whiteboard/object/category.dart';

class CategoryModel extends AbstractModel<Category> {
  @override
  int compare(Category a, Category b) => a.name.compareTo(b.name);
}
