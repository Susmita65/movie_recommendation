

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_provider/firebase_instances.dart';

final authService = Provider((ref) => AuthService(
    auth: ref.watch(auth),
));


class AuthService {
  final FirebaseAuth auth;
  AuthService({
    required this.auth,
});

  static final userDb = FirebaseFirestore.instance.collection('users');
  static Stream getUsers(String userId) {
    return userDb.doc(userId).snapshots().map((event) {
      final json = event.data() as Map<String, dynamic>;
      return json;
    });
  }
   Future<Either<String, bool>> userLogin({
    required String email,
     required String password
}) async{
     try {
      final response = await auth.signInWithEmailAndPassword(email: email, password: password);
      return Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.message.toString());
    }catch (err){
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> userSignUp({
    required String email,
    required String password,
    required String userName,

  }) async{
    try {
   final response = await auth.createUserWithEmailAndPassword(email: email, password: password);
   userDb.add(
   {
     'email': email,
     'userName': userName,
   }
   );
      return Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.message.toString());
    }on FirebaseException catch (err){
      return Left(err.message.toString());
    } catch (err){
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> userLogOut() async{
    try {
      final response = await auth.signOut();
      return Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.message.toString());
    }catch (err){
      return Left(err.toString());
    }
  }
}
