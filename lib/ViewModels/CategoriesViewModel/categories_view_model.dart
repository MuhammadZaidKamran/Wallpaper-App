import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class CategoriesViewModel extends BaseViewModel {
  ScrollController scrollController = ScrollController();
  List data = [];
  bool isLoading = false;

  Future<void> getData(search) async{
    try {
      isLoading = true;
      rebuildUi();
      var url = "https://api.unsplash.com/search/photos/?client_id=xQC1aEXPBPmm9saYWUlwKNjz1WR_ktDx0OXz0VsuR3U&query=$search&per_page=10&page=${data.length}";
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      var responseBody = jsonDecode(response.body);

      isLoading = false;
      data.addAll(responseBody["results"]);
      rebuildUi();
    } catch (e) {
      print(e);
    }
  }
}