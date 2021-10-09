import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class FireBaseStorage {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage(String image) async {
    ByteData bytes = await rootBundle.load(image);
    Directory tempDir = Directory.systemTemp;
    //* Create a reference to the picture
    String imageRef = image.substring(image.lastIndexOf("/"));
    print(imageRef);

    File file = File('${tempDir.path}/$imageRef');
    await file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

    //* Create a root reference
    Reference storageRef = storage.ref().child(imageRef);
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
