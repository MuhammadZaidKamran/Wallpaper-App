 import 'package:flutter_cache_manager/flutter_cache_manager.dart';
 //import 'package:wallpaper_manager/wallpaper_manager.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
//import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class ImageViewModel extends BaseViewModel {
   setHomeWallpaper(image) async{
   var cachedimage = await DefaultCacheManager().getSingleFile(image);  //image file
   int location = WallpaperManagerPlus.homeScreen;  //Choose screen type
   WallpaperManagerPlus().setWallpaper(cachedimage, location);
   }

   setLockWallpaper(image) async{
   var cachedimage = await DefaultCacheManager().getSingleFile(image);  //image file
   int location = WallpaperManagerPlus.lockScreen;  //Choose screen type
   WallpaperManagerPlus().setWallpaper(cachedimage, location);
   }

   setBothWallpaper(image) async{
   var cachedimage = await DefaultCacheManager().getSingleFile(image);  //image file
   int location = WallpaperManagerPlus.bothScreens;  //Choose screen type
   WallpaperManagerPlus().setWallpaper(cachedimage, location);
   }
}