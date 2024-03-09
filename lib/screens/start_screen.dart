import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_photochka/helper/app_image_picker.dart';
import 'package:photo_editor_photochka/providers/app_images_provider.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}): super(key:key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  late AppImageProvider imageProvider;

  @override
  void initState() {
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/walp.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: const Text(
                    "Фоточка",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10,
                        wordSpacing: 10
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AppImagePicker(source: ImageSource.gallery)
                              .pick(onPick: (File? image){
                                imageProvider.changeImageFile(image!);
                                Navigator.of(context).pushReplacementNamed('/home');
                          });
                        },
                        child: const Text("Gallery"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AppImagePicker(source: ImageSource.camera)
                              .pick(onPick: (File? image){
                                imageProvider.changeImageFile(image!);
                                Navigator.of(context).pushReplacementNamed('/home');
                          });
                        },
                        child: const Text("Camera"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
