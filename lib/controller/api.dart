
import 'dart:convert';
import 'package:cima_app/models/menu_api_model.dart';
import 'package:cima_app/models/texonomy_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
class ApiHandler{
  final String url;
  ApiHandler(this.url);
  Future<List<dynamic>> getData() async {
    var result = await http.get(Uri.parse(url));
    return json.decode(result.body);
  }
}

class FilteredData extends ApiHandler {
  String taxonamy;
  String termID;
  FilteredData({this.taxonamy = "category", this.termID = "31341"})
      : super("https://mycima.buzz/appweb/posts/archived_$taxonamy[$termID]/");
}

class FilmApi{
  Future<List<MenuModel>>getAllfilms()async{
    String url='https://mycima.fun/appweb/posts/archived_category[38365]/';
    try {

      var response = (await http.get(Uri.parse(url))) as Response;
      if (kDebugMode) {
        print(response.body.toString());
      }
      return response.body;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      //فى حاله وجود خطا طلع ليه ليست فاضيه
      return [];
    }
  }
}
class MenuApi{
  Future<List<MenuModel>>getDataMenu()async{
    String url="https://mycima.tube/appweb/menus/";
    var response = (await http.get(Uri.parse(url))) ;
    // if (kDebugMode) {
    //   print(response.body.toString());
    // }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => MenuModel.fromJson(e)).toList();
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
}
class TaxonomyApi{
  MenuModel menuModel=MenuModel();
  List<TaxonomyModel> results=[];
 Future<List<TaxonomyModel>> getDataCategory({String ?query})async{
    String url="https://mycima.fun/appweb/posts/archived_%7Btaxonomy%7D[%7Bterm%7D]/";
    var response = (await http.get(Uri.parse(url))) ;
    // if (kDebugMode) {
    //   print(response.body.toString());
    // }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      results= data.map((e) => TaxonomyModel.fromJson(e)).toList();
      if(query !=null){
        results=results.where((element) => element.title!.toLowerCase().contains(query.toLowerCase())).toList();
      }
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
    return results;
  }
  Future<List<TaxonomyModel>>getCategory({String id="38365"})async{
    String url="https://mycima.fun/appweb/posts/archived_category[$id]/";
   // String url="https://mycima.fun/appweb/posts/archived_category[${id}]/";
    if (kDebugMode) {
      print (url);
    }
    var response = (await http.get(Uri.parse(url))) ;
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => TaxonomyModel.fromJson(e)).toList();
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
  Future<List<TaxonomyModel>>getSubCategory({String id="5"})async{
    String url="https://mycima.fun/appweb/posts/archived_category[$id]/";
    if (kDebugMode) {
      print (url);
    }
    var response = (await http.get(Uri.parse(url))) ;
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => TaxonomyModel.fromJson(e)).toList();
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
}

