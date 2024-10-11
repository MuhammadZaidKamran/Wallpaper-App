import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class SearchViewModel extends BaseViewModel {

  List<String> categories = [
    "Architecture",
    "Art",
    "Movie",
    "Travel",
    "Animal",
    "Colorful",
    "Food",
    "Sport",
    "Minimalist",
    "Nature",
  ];

  filterCategory(value){
    categories = categories.where((element) => element.toLowerCase().contains(value.toString())).toList();
    rebuildUi();
  }

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  List data = [];
  bool isShimmer = false;

  fetchMoreData(search) async{
    try {
      isShimmer = true;
      rebuildUi();
      var url = "https://api.unsplash.com/search/photos/?client_id=xQC1aEXPBPmm9saYWUlwKNjz1WR_ktDx0OXz0VsuR3U&query=$search&per_page=10&page=${data.length}";
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      var responseBody = jsonDecode(response.body);

      data.addAll(responseBody["results"]);
      isShimmer = false;
      rebuildUi();
    } catch (e) {
      print(e);
    }
  }
  
  getSearchData(search) async{
    try {
      var url = "https://api.unsplash.com/search/photos/?client_id=xQC1aEXPBPmm9saYWUlwKNjz1WR_ktDx0OXz0VsuR3U&query=$search&per_page=10&page=${data.length}";
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      var responseBody = jsonDecode(response.body);

      data = responseBody["results"];
      rebuildUi();
    } catch (e) {
      print(e);
    }
  }

}