import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:deliverzler/auth/models/user_model.dart';
import 'package:deliverzler/core/errors/exceptions.dart';
import 'package:deliverzler/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());

class AuthRepo {
  String? _verificationId;

  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log(userCredential.toString());
      return Right(UserModel.fromUserCredential(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    } catch (e) {
      log(e.toString());
      final _errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    }
  }

  Future<Either<Failure, UserModel>> signInWithVerificationCode({
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
      return Right(UserModel.fromUserCredential(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      log("Testing verification flow");
      final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    } catch (e) {
      log(e.toString());
      final _errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    }
  }

  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(UserModel.fromUserCredential(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    } catch (e) {
      log(e.toString());
      final _errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    }
  }

  Future<Either<Failure, Future<dynamic>>> verificationByPhoneNumber(
      {required PhoneNumber mobile, required Duration timeout}) async {
    try {
      final completer = Completer<dynamic>();
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: mobile.phoneNumber.toString(),
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            log("Timeout! Code Auto Retrival: $_verificationId");
            _verificationId = verId;
            // notifyListeners();
          },
          codeSent: (String verificationId, [int? forceResendingToken]) async {
            log("Sending user verification code, navigating to next page: $verificationId");
            _verificationId = verificationId;
            completer.complete({"code": null, "message": "Successful"});
          },
          timeout: timeout,
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            log("This is the current user");
            completer.complete({"code": null, "message": "Successful"});
          },
          verificationFailed: (FirebaseAuthException e) {
            log("error code: ${e.code}, message: ${e.message}");
            final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
            ServerFailure(message: _errorMessage);
            completer.complete(e);
          });
      return Right(completer.future);
    } on FirebaseAuthException catch (e) {
      final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    } catch (e) {
      final _errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    }
  }

  Future<Either<Failure, void>> updatePhoneNumber({
    required String otp,
  }) async {
    try {
      log("Updating user phone number");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      final _result = await FirebaseAuth.instance.currentUser!
          .updatePhoneNumber(credential)
          .catchError(
              // ignore: return_of_invalid_type_from_catch_error
              (onError) => {print(onError.toString())});
      return Right(_result);
    } on FirebaseAuthException catch (e) {
      final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    } catch (e) {
      log(e.toString());
      final _errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  void verificationCompleted(AuthCredential phoneAuthCredential) {
    debugPrint(
        "This is the current user ${FirebaseAuth.instance.currentUser!.uid}");
  }

  void verificationFailed(FirebaseAuthException e) {
    debugPrint('error code: ${e.code}, message: ${e.message}');
    final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
    ServerFailure(message: _errorMessage);
  }
}
