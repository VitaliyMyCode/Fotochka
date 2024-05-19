import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pixel_color_picker/pixel_color_picker.dart';

class PixelColorImage {
  show(BuildContext context, {Color? backgroundColor, Uint8List? image, onPick}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Color tempColor = backgroundColor!;
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: Text('move'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PixelColorPicker(
                        child: Image.memory(image!),
                        onChanged: (color) {
                          setState(() {
                            tempColor = color;
                          });
                        }
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 80,
                      color: tempColor,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("cancel"),
                  ),
                  TextButton(
                      onPressed: () {
                        onPick(tempColor);
                        Navigator.of(context).pop();
                      },
                      child: Text("Pick"),
                  )
                ],
              );
            },
          );
        }
    );
  }
}







