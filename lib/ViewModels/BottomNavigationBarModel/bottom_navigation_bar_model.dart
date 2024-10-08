import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/Views/CollectionView/collection_view.dart';
import 'package:wallpaper_app_2/Views/HomeView/home_view.dart';
import 'package:wallpaper_app_2/Views/SearchView/search_view.dart';

class BottomNavigationBarModel extends BaseViewModel {
  List widgetList = [
    HomeView(),
    SearchView(),
    CollectionView(),
  ];

  int myIndex = 0;
}