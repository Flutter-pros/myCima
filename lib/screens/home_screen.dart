import 'package:cima_app/controller/api.dart';
import 'package:cima_app/models/menu_api_model.dart';
import 'package:cima_app/models/texonomy_model.dart';
import 'package:cima_app/screens/search.dart';
import 'package:cima_app/widget/drawer.dart';
import 'package:cima_app/widget/taxonomy_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  TaxonomyApi taxonomyApi = TaxonomyApi();
  MenuApi menuApi = MenuApi();
  late Future<List<TaxonomyModel>> taxonomyData;
  late Future<List<MenuModel>> menuData;
  late List<TaxonomyModel> allCategory;
  late List<TaxonomyModel>searchedForCategory;
  bool isSearched = false;
  final _searchedTextController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
   // taxonomyData = taxonomyApi.getDataCategory();
   // taxonomyData= taxonomyApi.getDataCategory() ;
   // menuData = menuApi.getDataMenu();

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
            onPressed: (){
              showSearch(context: context, delegate: SearchItem());
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body:SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(14, 19, 49, 1),
          child: Column(
            children: [
              buildTaxonomyList(),
            ],
          ),
        ),
      ),

    );
  }
  Widget buildTaxonomyList(){
    return FutureBuilder<List<TaxonomyModel>>(
        future: taxonomyApi.getDataCategory(),
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
              itemCount:data.length,
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
