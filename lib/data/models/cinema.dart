import 'package:flutter/material.dart';

class Cinema {
  final String id;
  final String displayName;
  final String link;
  final String address;

  Cinema({
    @required this.id,
    @required this.displayName,
    @required this.link,
    @required this.address,
  });

  Cinema.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        displayName = json['displayName'],
        link = json['link'],
        address = json['address'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['link'] = this.link;
    data['address'] = this.address;
    return data;
  }
}
