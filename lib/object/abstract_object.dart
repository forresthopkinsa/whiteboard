import 'dart:math';

abstract class AbstractObject {
  num id;

  AbstractObject() {
    id = _random.nextInt(10000);
  }

  bool same(AbstractObject other) =>
      this.runtimeType == other?.runtimeType && this.id == other?.id;
}

final _random = Random();
