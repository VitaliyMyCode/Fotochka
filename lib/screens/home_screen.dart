import 'package:flutter/material.dart';
import 'package:photo_editor_photochka/providers/app_images_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _savePhoto() async{
    final result = await ImageGallerySaver.saveImage(
        Provider.of<AppImageProvider>(context, listen: false).currentImage!,
        quality: 100,
        name: "${DateTime.now().millisecondsSinceEpoch}");
    if(!mounted) return false;
    if(result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('сохр')
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('не сохр')
          ),
      );
    }
  }
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
              onPressed: () {
                _savePhoto();
              },
              child: const Text('Сохранить')
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
                _bottonBatItem(Icons.crop_rotate, 'Обрезка',
                  onPress: () {
                    Navigator.of(context).pushNamed('/crop');
                  }
                ),
                _bottonBatItem(Icons.filter_vintage_outlined, 'Фильтры',
                  onPress: () {
                    Navigator.of(context).pushNamed('/filter');
                  }
                ),
                _bottonBatItem(Icons.tune, 'Регулировка',
                  onPress: () {
                    Navigator.of(context).pushNamed('/adjust');
                  }
                ),
                _bottonBatItem(Icons.fit_screen_sharp, 'Подгонка',
                  onPress: () {
                    Navigator.of(context).pushNamed('/fit');
                  }
                ),
                _bottonBatItem(Icons.border_color_outlined, 'Оттенок',
                  onPress: () {
                    Navigator.of(context).pushNamed('/tint');
                  }
                ),
                _bottonBatItem(Icons.blur_circular, 'Блюр',
                  onPress: () {
                    Navigator.of(context).pushNamed('/blur');
                  }
                ),
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

