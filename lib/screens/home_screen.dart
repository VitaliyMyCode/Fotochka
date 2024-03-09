import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_editor_photochka/providers/app_images_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Фоточка", style: TextStyle(color: Colors.white)),
        leading: CloseButton(color: Colors.white,
          onPressed: () {
              Navigator.of(context).pushNamed('/');
              }
            ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text('Save')
          )
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child){
            if(value.currentImage != null){
              return Image.memory(
                  value.currentImage!
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
                _bottonBatItem(Icons.crop_rotate, 'Crop',
                  onPress: () {
                    Navigator.of(context).pushNamed('/crop');
                  }
                ),
                _bottonBatItem(Icons.crop_rotate, 'Filters',
                  onPress: () {
                    Navigator.of(context).pushNamed('/crop');
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottonBatItem(IconData icon, String title, {required onPress}){
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 3),
            Text(title,
              style: const TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }

}

