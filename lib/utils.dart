import 'dart:convert';
import 'dart:io';

String imageToBase64(File image) {
  List<int> imageBytes = image.readAsBytesSync();
  return base64Encode(imageBytes);
}

File base64ToImage(String base64String) {
  return File.fromRawPath(base64Decode(base64String));
}
