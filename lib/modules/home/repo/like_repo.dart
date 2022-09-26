import 'package:zinggo_social/providers/api_provider.dart';
import 'package:zinggo_social/providers/log_provider.dart';
import 'package:zinggo_social/utils/model_type.dart';

abstract class CanLikeRepo {
  // true
  Future<bool> like(String id);

  // false
  Future<bool> unlike(String id);
}

class LikeRepo implements CanLikeRepo {
  final _apiProvider = ApiProvider();

  final String likeUrl;
  final String unlikeUrl;

  LogProvider get logger => const LogProvider('⚡️ LikeRepo');

  LikeRepo._internal(this.likeUrl, this.unlikeUrl);

  factory LikeRepo(ModelType type) {
    switch (type) {
      case ModelType.post:
        return LikeRepo._internal("/posts/:id/like", "/posts/:id/unlike");
      default:
        return LikeRepo._internal("/comments/:id/like", "/comments/:id/unlike");
    }
  }

  @override
  Future<bool> like(String id) async {
    final url = likeUrl.replaceFirst(":id", id);

    logger.log("calling api $url");

    try {
      var res = await _apiProvider.post(url);
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unlike(String id) async {
    final url = unlikeUrl.replaceFirst(":id", id);

    logger.log("calling api $url");

    try {
      var res = await _apiProvider.post(url);
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
