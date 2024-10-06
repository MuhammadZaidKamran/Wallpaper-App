import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/ViewModels/CategoriesViewModel/categories_view_model.dart';

class CategoriesView extends StatelessWidget {
  final String categories_item;
  const CategoriesView({super.key,required this.categories_item});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.getData(categories_item);
        viewModel.scrollController.addListener((){
          if (viewModel.scrollController.position.pixels == viewModel.scrollController.position.maxScrollExtent) {
           viewModel.getData(categories_item);
        }}
        );
      },
      viewModelBuilder: () => CategoriesViewModel(),
      builder: (context,viewModel,child){
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: Padding(
              padding: const EdgeInsets.only(left: 12,bottom: 10),
              child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(categories_item.toString(),style: GoogleFonts.aBeeZee(fontSize: 24,fontWeight: FontWeight.bold),)
                      ),
                          ),),
            elevation: 1,
            toolbarHeight: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 14,top: 14,bottom: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(54, 158, 158, 158)
                ),
                child: Center(
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
            backgroundColor: Colors.white,
           // title: Text(categories_item.toString()),
            centerTitle: true,
          ),
          body: 
          // body: viewModel.isLoading ?
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Column(
          //     children: [
          //       Center(child: SpinKitThreeBounce(
          //         size: 30,
          //         color: Colors.blue,
          //       )),
          //     ],
          //   ),
          // )
          // :
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: MasonryGridView.builder(
            padding: EdgeInsets.all(12),
            controller: viewModel.scrollController,
            itemCount: viewModel.data.length,
            shrinkWrap: false,
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
              itemBuilder: (context,index){
                final wallpaper = viewModel.data[index];
                double ht = index % 2 == 0 ? 200 : 100;
                if (viewModel.isLoading) {
                  return Center(
                    child: SpinKitThreeBounce(
                      size: 30,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(wallpaper['urls']['regular'],fit: BoxFit.cover,height: ht,),
                ); 
                }
              }
            ),
          ),
        );
      }
      );
  }
}