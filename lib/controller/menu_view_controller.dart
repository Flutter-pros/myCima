

import 'package:cima_app/controller/api.dart';
import 'package:get/get.dart';
class MenuController extends GetxController {
  ApiHandler apiMenu=ApiHandler("https://mycima.tube/appweb/menus/");
  FilteredData categoryData = FilteredData();
  FilmApi filmApi=FilmApi();
}