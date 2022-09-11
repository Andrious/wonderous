// import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/data/unsplash_photo_data.dart';
//import 'package:wonders/logic/unsplash_service.dart';

import 'package:wonders/src/controller.dart'
    show UnsplashService, unsplashService;
import 'package:wonders/src/model.dart' show UnsplashPhotoData;

UnsplashLogic get unsplashLogic => UnsplashLogic();

class UnsplashLogic {
  factory UnsplashLogic() => _this ??= UnsplashLogic._();
  UnsplashLogic._();
  static UnsplashLogic? _this;

  final Map<String, List<String>> _idsByCollection =
      UnsplashPhotoData.photosByCollectionId;

  UnsplashService get service =>
      unsplashService; //GetIt.I.get<UnsplashService>();

  List<String>? getCollectionPhotos(String collectionId) =>
      _idsByCollection[collectionId];
}
