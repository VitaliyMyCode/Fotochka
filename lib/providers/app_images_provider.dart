import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppImageProvider extends ChangeNotifier {

  Uint8List? currentImage;

  changeImageFile(File image){
    currentImage = image.readAsBytesSync();
    notifyListeners();
  }

  changeImage(Uint8List image){
    currentImage = image;
    notifyListeners();
  }



}