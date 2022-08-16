// ignore_for_file: unrelated_type_equality_checks

import 'package:cima_app/controller/api.dart';
import 'package:cima_app/models/texonomy_model.dart';
import 'package:cima_app/widget/drawer.dart';
import 'package:cima_app/widget/taxonomy_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/menu_api_model.dart';
class FilmsScreen extends StatefulWidget {
  const FilmsScreen({Key? key}) : super(key: key);

  @override
  _FilmsScreenState createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  MenuApi menuApi = MenuApi();
  TaxonomyApi taxonomyApi = TaxonomyApi();
  late Future<List<TaxonomyModel>> taxonomyData;
  late Future<List<MenuModel>> menuData;
  MenuModel menuModel=MenuModel();
  Children children=Children();
  @override
  void initState() {

       taxonomyData = taxonomyApi.getCategory(
         id: menuModel.id = "38365",
       );


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        title: const Text(
          'MYCIMA',
          style: TextStyle(
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
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(14, 19, 49, 1),
          child: Column(
            children: [
              buildFilmsList(),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildFilmsList(){
    return FutureBuilder<List<TaxonomyModel>>(
        future: taxonomyData,
        builder: (BuildContext context, AsyncSnapshot snapshot){

          if(snapshot.hasData){
            final data = snapshot.data as List<TaxonomyModel>;
            return  GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount:  data.length,
              itemBuilder: (context, index) {
                return TaxonomyItem(
                    taxonomyModel: data[index]
                );
              },
              //allCharacters[index]
            );
          }else if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error.toString());
            }
            return const Text('has error');
          } else {
            return  showLoadingIndicator();
          }
        }
    );
  }
  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    );
  }
}
