import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/Api_app/controller/post_controller.dart';

class PostView extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX API Example'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: postController.postList.length,
            itemBuilder: (context, index) {
              var post = postController.postList[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        }
      }),
    );
  }
}
