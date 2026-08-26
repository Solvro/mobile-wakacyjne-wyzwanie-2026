import 'package:flutter/material.dart';

class Place {
  final String id;
  final String title;
  final String description;
  final String shortdesc;
  final String path;
  final bool isFavorite;
  final Color backcolor;
  final List<String> listastr;
  final List<Icon> listaicon;

  const Place(
      {required this.id,
      required this.title,
      required this.shortdesc,
      required this.description,
      this.isFavorite = false,
      required this.path,
      required this.backcolor,
      required this.listastr,
      required this.listaicon});

  Place copyWith({bool? isFavorite}) {
    return Place(
        id: id,
        title: title,
        description: description,
        path: path,
        backcolor: backcolor,
        shortdesc: shortdesc,
        isFavorite: isFavorite ?? this.isFavorite,
        listastr: listastr,
        listaicon: listaicon);
  }
}
