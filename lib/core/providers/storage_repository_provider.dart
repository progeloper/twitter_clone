import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';


final storageRepoProvider = Provider((ref) {
  final storage = ref.read(firebaseStorageProvider);
  return FirebaseStorageRepository(storage: storage);
});

class FirebaseStorageRepository{
  final FirebaseStorage _storage;
  FirebaseStorageRepository({required FirebaseStorage storage}):_storage = storage;

  FutureEither<String> storeFile(String path, String id, File? file) async{
    try{
      final ref = _storage.ref().child(path).child(id);
      TaskSnapshot uploadTask = await ref.putFile(file!);
      final snapshot = uploadTask;
      return right(await snapshot.ref.getDownloadURL());
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

  FutureEither<String> storeImage(String path, String id, Uint8List file)async{
    try{
      final Reference ref = _storage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snap = await uploadTask;
      return right(await snap.ref.getDownloadURL());
    }on FirebaseException catch(e){
      throw e.message!;
    } catch(e){
      return left(Failure(e.toString()));
    }
  }
}