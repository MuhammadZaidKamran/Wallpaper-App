import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/ViewModels/HomeViewModel/home_view_model.dart';
import 'package:wallpaper_app_2/Views/CategoriesView/categories_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context,viewModel,child){
        return Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            title: Text("Icon"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12,left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Collections",style: GoogleFonts.aBeeZee(fontSize: 28,fontWeight: FontWeight.bold),)
                    ),
                ),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 5),
                    itemCount: viewModel.categories.length,
                    itemBuilder: (context,index){
                      final item = viewModel.categories[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesView(categories_item: item)));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 12),
                          margin: EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage("assets/images/${item}.jpg"),fit: BoxFit.cover)
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(item.toString(),style: GoogleFonts.acme(fontSize: 45,color: Colors.white,fontWeight: FontWeight.bold),)),
                        ),
                      );
                    }
                    ),
                ),
              ],
            ),
          ),
        );
      }
      );
  }
}