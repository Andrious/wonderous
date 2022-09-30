import 'package:unsplash_client/unsplash_client.dart';
// import 'package:wonders/logic/data/unsplash_photo_data.dart';

import 'package:wonders/src/model.dart' show UnsplashPhotoData;

/// Note: This service is no-longer used in the production app, but exist to enable development tools like [UnsplashDownloadService]
String unsplashAccessKey = 'dxqHsX7IOURA5hfh0fuhL-cuX6q2-5DqghC77mnmrAU';
String unsplashSecretKey = 'yTDPsxt6soBmcym7shd24t4vlYYDcOnzWyJ07O3UyEY';

///
UnsplashService get unsplashService => UnsplashService();

///
class UnsplashService {
  ///
  factory UnsplashService() => _this ??= UnsplashService._();
  UnsplashService._();
  static UnsplashService? _this;

  ///
  final client = UnsplashClient(
    settings: ClientSettings(
      credentials: AppCredentials(
        accessKey: unsplashAccessKey,
        secretKey: unsplashSecretKey,
      ),
    ),
  );

  ///
  Future<List<String>?> loadCollectionPhotos(String id) async {
    final photo =
        await client.collections.photos(id, page: 1, perPage: 25).go();
    final data = photo.data;
    if (data == null) {
      return null;
    }
    return data.map((e) => e.id).toList();
  }

  ///
  Future<UnsplashPhotoData?> loadInfo(String id) async {
    final photo = await client.photos.get(id).go();
    final data = photo.data;
    if (data == null) {
      throw 'Photo did not load. statusCode=${photo.statusCode}';
    }
    return UnsplashPhotoData(id: id, url: '${data.urls.raw}');
  }
}
