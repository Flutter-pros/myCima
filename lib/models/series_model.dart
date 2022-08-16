
import 'dart:convert';

import 'package:http/http.dart' as http;
class SeriesModel {
  String? termID;
  String? title;
  String? year;
  int? author;
  String? thumbnailUrl;

  SeriesModel(
      {this.termID, this.title, this.year, this.author, this.thumbnailUrl});

  SeriesModel.fromJson(Map<String, dynamic> json) {
    termID = json['termID'];
    title = json['title'];
    year = json['year'];
    author = json['author'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['termID'] = termID;
    data['title'] = title;
    data['year'] = year;
    data['author'] = author;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}

class SeriesApi{
  Future<List<SeriesModel>>getDataFilm()async{
    String url="https://mycima.fun/appweb/posts/archived_category[31341]/";
    var response = (await http.get(Uri.parse(url))) ;
    // if (kDebugMode) {
    //   print(response.body.toString());
    // }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) =>SeriesModel.fromJson(e)).toList();
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
}
