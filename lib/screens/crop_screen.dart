import 'dart:typed_data';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_photochka/providers/app_images_provider.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class CropScreen extends StatefulWidget {
  const CropScreen({Key? key}) : super(key: key);

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {

  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  late AppImageProvider imageProvider;

  @override
  void initState() {
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(color: Colors.white),
        title: const Text("Обрезка", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: () async {
                ui.Image bitmap = await controller.croppedBitmap();
                ByteData? data = await bitmap.toByteData(format: ImageByteFormat.png);
                Uint8List bytes = data!.buffer.asUint8List();
                imageProvider.changeImage(bytes);
                if(!mounted) return;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done, color: Colors.white)
          )
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child){
            if(value.currentImage != null){
              return CropImage(
                controller: controller,
                image: Image.memory(value.currentImage!),


              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _bottonBatItem(
                    child: const Icon(Icons.rotate_90_degrees_ccw_outlined,
                                      color: Colors.white,),
                    onPress: () {
                      controller.rotateLeft();
                    }
                ),
                _bottonBatItem(
                    child: const Icon(Icons.rotate_90_degrees_cw_outlined,
                                      color: Colors.white),
                    onPress: () {
                      controller.rotateRight();
                    }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    color: Colors.white70,
                    height: 20,
                    width: 1,
                  ),
                ),
                _bottonBatItem(
                    child: const Text('Свободный',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = null;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),
                _bottonBatItem(
                    child: const Text('1:1',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 1;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),
                _bottonBatItem(
                    child: const Text('2:1',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 2;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),_bottonBatItem(
                    child: const Text('1:2',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 1 / 2;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),
                _bottonBatItem(
                    child: const Text('4:3',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 4 / 3;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),_bottonBatItem(
                    child: const Text('3:4',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 3 / 4;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),
                _bottonBatItem(
                    child: const Text('16:9',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 16 / 9;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                ),
                _bottonBatItem(
                    child: const Text('9:16',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPress: () {
                      controller.aspectRatio = 9 / 16;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _bottonBatItem({required child ,required onPress}){
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: child,
        )
      ),
    );
  }
}
