
import 'package:flutter/foundation.dart';

class Users {
 final String id;
 final String name;
 final String age;
}

Users({required this.id, required this.name, required this.age});

Factory Users.fromJson(Map<String, dynamic> json) {
  return Users(
    id: json['id'],
    name: json['name'],
    age: json['age'],
  );

}
