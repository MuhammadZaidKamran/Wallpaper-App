import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/ViewModels/HomeViewModel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.getHomeData1();
        viewModel.getHomeData2();
        viewModel.scrollHomeController.addListener((){
          if (viewModel.scrollHomeController.position.pixels == viewModel.scrollHomeController.position.maxScrollExtent) {
            viewModel.getHomeData1();
          }
        });
        viewModel.scrollHomeController_2.addListener((){
          if (viewModel.scrollHomeController_2.position.pixels == viewModel.scrollHomeController_2.position.maxScrollExtent) {
            viewModel.getHomeData2();
          }
        });
      },
      viewModelBuilder: () => HomeViewModel(),
      builder: (context,viewModel,child){
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            title: Text("App Icon"),
            centerTitle: true,
          ),
          drawer: Drawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 4, 55, 96)
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              // style: ButtonStyle(
                              //   backgroundColor: WidgetStatePropertyAll()
                              // ),
                              onTap: (){
                              viewModel.isGrid = false;
                              viewModel.rebuildUi();
                            }, child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: viewModel.isGrid ? const Color.fromARGB(105, 96, 125, 139) : Colors.purple,
                              ),
                              child: Center(child: Icon(Icons.grid_view_outlined,size: 21,color: Colors.white,)))),
                            InkWell(
                              // style: ButtonStyle(
                              //   backgroundColor: WidgetStatePropertyAll()
                              // ),
                              onTap: (){
                              viewModel.isGrid = true;
                              viewModel.rebuildUi();
                            }, child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: viewModel.isGrid ? Colors.purple : const Color.fromARGB(105, 96, 125, 139),
                              ),
                              child: Center(child: Icon(Icons.grid_view_rounded,color: Colors.white,size: 21,)))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: viewModel.isGrid ?
                  MasonryGridView.builder(
                    controller: viewModel.scrollHomeController_2,
                    itemCount: viewModel.data_2.length,
                    padding: EdgeInsets.all(15),
                    physics: AlwaysScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context,index){
                      final imgList = viewModel.data_2[index];
                        return viewModel.isShimmer ?
                        Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: const Color.fromARGB(69, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(imgList['urls']['regular'],filterQuality: FilterQuality.high,fit: BoxFit.cover,),
                          ),
                        )
                        :
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(imgList['urls']['regular'],filterQuality: FilterQuality.high,fit: BoxFit.cover,),
                          );
                    }
                    )
                  :
                  GridView.builder(
                    controller: viewModel.scrollHomeController,
                    itemCount: viewModel.data.length,
                    padding: EdgeInsets.all(15),
                    physics: AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2 / 3.5,
                      ),
                      itemBuilder: (context,index){
                        final imgList = viewModel.data[index];
                        return viewModel.isShimmer ?
                        Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: const Color.fromARGB(69, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(imgList['urls']['regular'],filterQuality: FilterQuality.high,fit: BoxFit.cover,),
                          ),
                        )
                        :
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(imgList['urls']['regular'],filterQuality: FilterQuality.high,fit: BoxFit.cover,),
                          );
                      }
                      ),
                )
              ],
            ),
          ),
        );
      }
      );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stacked/stacked.dart';
// import 'package:wallpaper_app_2/ViewModels/CollectionViewModel/collection_view_model.dart';
// import 'package:wallpaper_app_2/Views/CategoriesView/categories_view.dart';

// class CollectionView extends StatelessWidget {
//   const CollectionView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//       viewModelBuilder: () => CollectionViewModel(),
//       builder: (context,viewModel,child){
//         return Scaffold(
//           drawer: Drawer(),
//           appBar: AppBar(
//             elevation: 2,
//             backgroundColor: Colors.white,
//             title: Text("Icon"),
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(top: 12,left: 12),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Collections",style: GoogleFonts.aBeeZee(fontSize: 28,fontWeight: FontWeight.bold),)
//                     ),
//                 ),
//                 SizedBox(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 5),
//                     itemCount: viewModel.categories.length,
//                     itemBuilder: (context,index){
//                       final item = viewModel.categories[index];
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesView(categories_item: item)));
//                         },
//                         child: Container(
//                           padding: EdgeInsets.only(left: 12),
//                           margin: EdgeInsets.only(top: 20),
//                           height: MediaQuery.of(context).size.height * 0.22,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(image: AssetImage("assets/images/${item}.jpg"),fit: BoxFit.cover)
//                           ),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(item.toString(),style: GoogleFonts.acme(fontSize: 45,color: Colors.white,fontWeight: FontWeight.bold),)),
//                         ),
//                       );
//                     }
//                     ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//       );
//   }
// }