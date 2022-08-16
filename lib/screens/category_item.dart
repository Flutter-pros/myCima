import 'package:cima_app/widget/drawer.dart';
import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  final String title;
  const CategoryItem({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        title:  Text(
          title,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search,color: Colors.white,),
            onPressed: (){},
          ),
        ],
      ),
      drawer: const DrawerWidget(),

    );

  }
}

