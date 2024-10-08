import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends BaseViewModel {
  bool isGrid = false;
  bool isShimmer = false;
  ScrollController scrollHomeController = ScrollController();
  ScrollController scrollHomeController_2 = ScrollController();
  List data = [];
  List data_2 = [];

  getHomeData1() async{
    try {
     isShimmer = true;
     rebuildUi(); 
    var url = "https://api.unsplash.com/photos/?client_id=xQC1aEXPBPmm9saYWUlwKNjz1WR_ktDx0OXz0VsuR3U&per_page=15&page=${data.length}";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var responseBody = jsonDecode(response.body);

    data.addAll(responseBody);
    isShimmer = false;
    rebuildUi();
    } catch (e) {
      print(e);
    }
  }


  getHomeData2() async{
    try {
     isShimmer = true;
     rebuildUi(); 
    var url = "https://api.unsplash.com/photos/?client_id=xQC1aEXPBPmm9saYWUlwKNjz1WR_ktDx0OXz0VsuR3U&per_page=15&page=${data.length}";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var responseBody = jsonDecode(response.body);

    data_2.addAll(responseBody);
    isShimmer = false;
    rebuildUi();
    } catch (e) {
      print(e);
    }
  }
}