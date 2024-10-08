import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/ViewModels/SearchViewModel/search_view_model.dart';
import 'package:wallpaper_app_2/Views/CategoriesView/categories_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.scrollController.addListener((){
          if (viewModel.scrollController.position.pixels == viewModel.scrollController.position.maxScrollExtent) {
            viewModel.fetchMoreData(viewModel.searchController.text);
          }
        });
      },
      viewModelBuilder: () => SearchViewModel(),
      builder: (context,viewModel,child){
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, 135), child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(left: 15,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Search",style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 3,),
                        Text("searching through hundreds of photos will be\nso much easier now.",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11),),
                        SizedBox(height: 5,),
                        TabBar(tabs: [Tab(text: "Photo",),Tab(text: "Category",)],dividerColor: Colors.white,),
                ],
              ),
            ),
            ),
            body: TabBarView(
              children: [
                 SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [   
                      //SizedBox(height: 20,),
                      TextField(
                        controller: viewModel.searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.wallpaper,size: 23,),
                          hintText: "Search images (sports, travel)...",
                          hintStyle: GoogleFonts.actor(
                            fontWeight: FontWeight.normal
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              viewModel.getSearchData(viewModel.searchController.text);
                            },
                            child: Icon(Icons.search_rounded,size: 27,)
                            ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.1,
                              color: const Color.fromARGB(255, 93, 33, 243),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                       SizedBox(height: 10,),
                    //  // TabBar(tabs: [Tab(text: "Photo",),Tab(text: "Category",)],dividerColor: Colors.white,),
                    //   SizedBox(height: 20,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                          controller: viewModel.scrollController,
                          itemCount: viewModel.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2 / 3.5,
                            ), itemBuilder: (context,index){
                              final image = viewModel.data[index];
                            return viewModel.isShimmer ?
                            Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: const Color.fromARGB(69, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(image['urls']['regular'],fit: BoxFit.cover,),
                              ),
                            )
                            :
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(image['urls']['regular'],fit: BoxFit.cover,),
                              );
                          }
                          ),
                      ),
                    ],
                  ),
                ),
              ),




              SingleChildScrollView(
                child: Container(
                  //margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("Search",style: GoogleFonts.aBeeZee(
                      //   fontSize: 20,
                      //   fontWeight: FontWeight.bold
                      // ),),
                      // SizedBox(height: 3,),
                      // Text("searching through hundreds of photos will be\nso much easier now.",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
                      // SizedBox(height: 20,),
                      TextField(
                        onChanged: (value) => viewModel.filterCategory(value),
                        controller: viewModel.searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.wallpaper,size: 23,),
                          hintText: "Search Category",
                          hintStyle: GoogleFonts.actor(
                            fontWeight: FontWeight.normal
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              viewModel.filterCategory(viewModel.searchController.text);
                              //viewModel.getSearchData(viewModel.searchController.text);
                            },
                            child: Icon(Icons.search_rounded,size: 27,)
                            ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.1,
                              color: const Color.fromARGB(255, 93, 33, 243),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    //   SizedBox(height: 15,),
                    //  // TabBar(tabs: [Tab(text: "Photo",),Tab(text: "Category",),],dividerColor: Colors.white,),
                    //   SizedBox(height: 20,),
                      SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 0,right: 0,bottom: 12,top: 8),
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
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height,
                      //   child: GridView.builder(
                      //     controller: viewModel.scrollController,
                      //     itemCount: viewModel.data.length,
                      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2,
                      //       mainAxisSpacing: 8,
                      //       crossAxisSpacing: 8,
                      //       childAspectRatio: 2 / 3.5,
                      //       ), itemBuilder: (context,index){
                      //         final image = viewModel.data[index];
                      //       return ClipRRect(
                      //         borderRadius: BorderRadius.circular(12),
                      //         child: Image.network(image['urls']['regular'],fit: BoxFit.cover,),
                      //       );
                      //     }
                      //     ),
                      // ),
                    ],
                  ),
                ),
              ),
              ]
            ),
          ),
        );
      }
      );
  }
}