import 'package:cima_app/controller/api.dart';
import 'package:cima_app/models/texonomy_model.dart';
import 'package:cima_app/widget/taxonomy_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class SearchItem extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: (){
            query="";
          },
          icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
    );
  }
  TaxonomyApi taxonomyApi = TaxonomyApi();
  @override
  Widget buildResults(BuildContext context) {
   return SingleChildScrollView(
     child: Container(
       color: const Color.fromRGBO(14, 19, 49, 1),
       child: Column(
         children: [
           buildTaxonomyList(),
         ],
       ),
     ),
   );
  }
  Widget buildTaxonomyList(){
    return FutureBuilder<List<TaxonomyModel>>(
        future: taxonomyApi.getDataCategory(query: query),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('search item'),
    );
  }

}