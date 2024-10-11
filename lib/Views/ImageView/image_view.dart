//import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_app_2/ViewModels/ImageViewModel/image_view_model.dart';
import 'package:wallpaper_app_2/Views/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:wallpaper_app_2/Views/HomeView/home_view.dart';

class ImageView extends StatelessWidget {
  final dynamic image;
  const ImageView({super.key , this.image});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ImageViewModel(),
      builder: (context,viewModel,child){
        return  InstaImageViewer(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image),filterQuality: FilterQuality.high,fit: BoxFit.cover)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(onPressed: () {
                     // viewModel.setWallpaper(image);
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context){
                        return SizedBox(
                          height: MediaQuery.of(context).size.height*0.33,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                               Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () async{
                                    await viewModel.setHomeWallpaper(image);
                                    Navigator.pop(context);
                                    showDialog(context: context, builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      content: Text("Wallpaper is set as Home screen successfully.",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                                      actions: [
                                        Center(
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 45,
                                            minWidth: MediaQuery.of(context).size.width,
                                            color: const Color.fromARGB(255, 156, 89, 255),
                                            onPressed: (){
                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                                          },child: Text("Back to Home",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),),
                                        )
                                      ],
                                    )
                                    );
                                  }, child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Set as Home screen",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),)))),
                                 // SizedBox(height: 10,),
                                  Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () async{
                                    await viewModel.setLockWallpaper(image);
                                    Navigator.pop(context);
                                  }, child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Set as Lock screen",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),)))),
                                  //SizedBox(height: 10,),
                                  Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () async{
                                    await viewModel.setBothWallpaper(image);
                                    Navigator.pop(context);
                                  }, child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Set as Both",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),)))),
                                  //SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        );
                      });
                    },child: Text("Apply",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),color: const Color.fromARGB(127, 33, 149, 243),height: 50,minWidth: MediaQuery.of(context).size.width,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),)
                  ],
                ),
              ),
            ),
          );
      }
      );
  }
}