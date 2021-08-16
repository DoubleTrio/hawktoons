import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _defaultReference = FirebaseStorage.instance.ref('user');

abstract class ImageRepository {
  Future<PickedFile?> getImage();
  Future<String> uploadImage({ required File file, required String uid });
}

class CartoonImageRepository implements ImageRepository {
  CartoonImageRepository({
    Reference? reference
  }) : _reference = reference ?? _defaultReference;

  final Reference _reference;

  @override
  Future<PickedFile?> getImage() async {
    PickedFile? image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 640,
      maxHeight: 480,
    );
    return image;
  }

  @override
  Future<String> uploadImage({ required File file, required String uid }) async {
    final ref = _reference.child('$uid/i');
    final task = ref.putFile(file);
    final snapshot = await task.whenComplete(() => {
    });
    return snapshot.ref.getDownloadURL();
  }
}