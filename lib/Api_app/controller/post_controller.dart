import 'package:get/get.dart';
import 'package:getx_programing/Api_app/modal/mainmodal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <Post>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        postList.value = jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } finally {
      isLoading(false);
    }
  }
}
