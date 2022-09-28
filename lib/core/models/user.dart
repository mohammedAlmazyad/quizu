import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String name;
  String phone;
  User({
    @required this.name,
    @required this.phone,
  });
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['mobile'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
