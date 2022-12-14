import 'dart:convert';

import 'package:http/http.dart' as http;


class FilmModel {
  String? id;
  String? title;
  String? year;
  int? author;
  String? thumbnailUrl;

  FilmModel({this.id, this.title, this.year, this.author, this.thumbnailUrl});

  FilmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    author = json['author'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['year'] = year;
    data['author'] = author;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}
class FilmsApi{
  Future<List<FilmModel>>getDataFilm()async{
    String url="https://mycima.fun/appweb/posts/archived_category[38365]/";
    var response = (await http.get(Uri.parse(url))) ;
    // if (kDebugMode) {
    //   print(response.body.toString());
    // }
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) =>FilmModel.fromJson(e)).toList();
      //return jsonResponse.map((data) => Data.fromJson(data)).toList();
    }else{
      throw Exception('error');
    }
  }
}
