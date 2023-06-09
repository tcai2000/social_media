import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media/constants/index.dart';
import 'package:social_media/models/user/user_hive.dart';

class PostApi {
  Future<Response> createPostApi(
      Map<String, dynamic> data, Map<String, dynamic> headerData) async {
    final formData = FormData.fromMap(data);
    final dio = Dio();
    var addPostUri = Uri.https(dotenv.env["URL_MAIN"]!, ApiPath.addPost);
    Response res = await dio.postUri(
      addPostUri,
      data: formData,
      options: Options(headers: headerData),
    );
    return res;
  }

  Future<Map<String, dynamic>?> editPostApi() async {}

  Future<Map<String, dynamic>?> deletePostApi() async {}

  // show app post
  Future<Response?> showAllPostApi({Map<String, dynamic>? inputHeader}) async {
    Uri allPostUri = Uri.https(dotenv.env["URL_MAIN"]!, ApiPath.allPosts);
    final dio = Dio();
    //var box = await Hive.openBox("myBox");
    //UserHive user = Hive.box("myBox").get("me");
    //print("user ${user.token}");

    try {
      return await dio.getUri(
        allPostUri,
        options: Options(
          headers: inputHeader,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  // show app post
  Future<Response?> favoritePostApi(
      Map<String, dynamic> inputData, String postId) async {
    Uri favoritePostUri =
        Uri.https(dotenv.env["URL_MAIN"]!, "${ApiPath.favorites}/$postId");
    //print("=== ${favoritePostUri}");
    final dio = Dio();
    var box = await Hive.openBox("myBox");
    UserHive user = box.getAt(0);
    try {
      return await dio.postUri(
        favoritePostUri,
        data: inputData,
        options: Options(
          headers: {"Authorization": "JWT ${user.token}"},
        ),
      );
    } catch (e) {
      return null;
    }
  }

  Future<Response?> showFavoritePostApi(String postId) async {
    Uri favoritePostUri =
        Uri.https(dotenv.env["URL_MAIN"]!, "${ApiPath.favorites}/$postId");
    //print("=== ${favoritePostUri}");
    final dio = Dio();
    var box = await Hive.openBox("myBox");
    UserHive user = box.getAt(0);
    try {
      return await dio.getUri(
        favoritePostUri,
        options: Options(
          headers: {"Authorization": "JWT ${user.token}"},
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
