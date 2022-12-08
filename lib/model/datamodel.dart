import 'package:flutter/material.dart';

class UserModel with ChangeNotifier{
  late String name;

  UserModel({
    required this.name,
}
);
  Map<String, dynamic> toMap() => {
    "name": name,
  };


}

