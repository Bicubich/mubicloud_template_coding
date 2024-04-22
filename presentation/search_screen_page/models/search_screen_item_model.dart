import 'package:get/get.dart';

/// This class is used in the [search_screen_item_widget] screen.

class SearchScreenItemModel {
  Rx<String> numberlikhTxt = Rx("Number likh");

  Rx<String>? id = Rx("");
  String? title;
  SearchScreenItemModel(this.title);
}
