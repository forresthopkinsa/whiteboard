import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whiteboard/object/abstract_object.dart';

class Category extends AbstractObject {
  String name;
  Color color;

  Category(this.name, [this.color]) : super() {
    if (color == null) {
      color = Colors.primaries[_random.nextInt(18)];
    }
  }

  CircleAvatar get avatar => CircleAvatar(
        child: Text(name[0]),
        backgroundColor: color,
      );
}

final _random = Random();
