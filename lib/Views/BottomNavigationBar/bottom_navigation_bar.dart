import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/ViewModels/BottomNavigationBarModel/bottom_navigation_bar_model.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BottomNavigationBarModel(),
      builder: (context,viewModel,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: viewModel.widgetList[viewModel.myIndex],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              animationCurve: Curves.bounceOut,
              buttonBackgroundColor: Color.fromARGB(255, 10, 45, 73),
              color: const Color.fromARGB(255, 10, 45, 73),
              backgroundColor:  const Color.fromARGB(0, 0, 0, 0),
              height: 55,
              index: viewModel.myIndex,
              onTap: (value) {
                viewModel.myIndex = value;
                viewModel.rebuildUi();
              },
              items: [
                Icon(Icons.home,color: Colors.white,),
                Icon(Icons.search,color: Colors.white,),
                Icon(Icons.grid_view_rounded,color: Colors.white,),
              ]),
          ),
        );
      }
      );
  }
}