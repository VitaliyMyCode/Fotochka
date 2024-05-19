import 'package:flutter/material.dart';
import 'package:photo_editor_photochka/model/tint.dart';

class Tints{

  List<Tint> list(){
    return[
      Tint(color: Colors.orange),
      Tint(color: Colors.green),
      Tint(color: Colors.yellow),
      Tint(color: Colors.blue),
      Tint(color: Colors.pink),
      Tint(color: Colors.purple),
      Tint(color: Colors.red),
    ];
  }
}