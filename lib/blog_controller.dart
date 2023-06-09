import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'blog_model.dart';

class BlogController extends GetxController {
  static BlogController get to => Get.find();
  final _box = GetStorage();

  var blogs = <Blog>[].obs;

  var image = Rxn<File>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onInit() {
    // Load blogs from storage
    _box.getKeys().forEach((key) {
      final blog = Blog.fromJson(_box.read(key));
      if (blog.imagePath != null) {
        blog.image = File(blog.imagePath!);
      }
      blogs.add(blog);
    });

    super.onInit();
  }

  /// Pick image from gallery
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  /// Save blog image to local storage and return image path
  Future<String> _saveBlogImage(String id, File image) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocDir.path}/$id');
    file.writeAsBytesSync(image.readAsBytesSync());
    return file.path;
  }

  /// Add blog to storage
  Future<void> addBlog(Blog blog) async {
    // Save image to local storage
    if (blog.image != null) {
      blog.imagePath = await _saveBlogImage(blog.id, blog.image!);
    }

    await _box.write(blog.id, blog.toJson());
    blogs.add(blog);
    image.value = null;
  }

  /// Delete blog from storage
  void deleteBlog(Blog blog) {
    _box.remove(blog.id);
    blogs.remove(blog);
  }

  /// Update blog in storage
  void updateBlog(Blog blog) async {
    // Update image
    if (blog.image != null) {
      blog.imagePath = await _saveBlogImage(blog.id, blog.image!);
    }

    _box.write(blog.id, blog.toJson());
    final index = blogs.indexWhere((element) => element.id == blog.id);
    blogs[index] = blog;
  }
}
