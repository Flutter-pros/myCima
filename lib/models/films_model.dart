class FilmsModel {
  String ?id;
  String ?title;
  String ?year;
  int ?author;
  String ?thumbnailUrl;

  FilmsModel({this.id, this.title, this.year, this.author, this.thumbnailUrl});

  FilmsModel.fromJson(Map<String, dynamic> json) {
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
