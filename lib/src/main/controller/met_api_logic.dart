import 'dart:collection';

//import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/common/string_utils.dart';
// import 'package:wonders/logic/data/artifact_data.dart';
// import 'package:wonders/logic/met_api_service.dart';
// import 'package:wonders/logic/common/http_client.dart';

import 'package:wonders/src/controller.dart'
    show $strings, MetAPIService, ServiceResult, StringUtils, metAPIService;
import 'package:wonders/src/model.dart' show ArtifactData;

///
MetAPILogic get metAPILogic => MetAPILogic();

///
class MetAPILogic {
  ///
  factory MetAPILogic() => _this ??= MetAPILogic._();
  MetAPILogic._();
  static MetAPILogic? _this;

  final HashMap<String, ArtifactData?> _artifactCache = HashMap();

  ///
  MetAPIService get service => metAPIService; // GetIt.I.get<MetAPIService>();

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(String id) async {
    if (_artifactCache.containsKey(id)) {
      return _artifactCache[id];
    }
    final ServiceResult<ArtifactData?> result = await service.getObjectByID(id);
    if (!result.success) {
      throw StringUtils.supplant(
          $strings.artifactDetailsErrorNotFound('{artifactId}'),
          {'{artifactId}': id});
    }
    final ArtifactData? artifact = result.content;
    return _artifactCache[id] = artifact;
  }
}
