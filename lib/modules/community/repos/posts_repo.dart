import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:deliverzler/auth/repos/user_repo.dart';
import 'package:deliverzler/modules/community/models/post_model.dart';
import 'package:deliverzler/core/errors/exceptions.dart';
import 'package:deliverzler/core/errors/failures.dart';
import 'package:deliverzler/core/services/firebase_services/firebase_caller.dart';
import 'package:deliverzler/core/services/firebase_services/firestore_paths.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postRepoProvider = Provider<PostsRepo>((ref) => PostsRepo(ref));

class PostsRepo {
  PostsRepo(this.ref) {
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  late String? uid;

  late UserRepo _userRepo;
  final FirebaseCaller _firebaseCaller = FirebaseCaller.instance;
  late PostModel? postsModel;

//  GET - Main Posts - Stream
  Stream<List<PostModel>> getPostsStream({required String communityId}) {
    return _firebaseCaller.collectionStream<PostModel>(
      path: FirestorePaths.postCollection(),
      queryBuilder: (query) =>
          query.where('communityId', isEqualTo: communityId),
      builder: (snapshotData, snapshotId) {
        return PostModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

//  GET - Comments - By Post - Stream
  Stream<List<PostModel>> getCommentStream({required String postId}) {
    return _firebaseCaller.collectionStream<PostModel>(
      path: FirestorePaths.commentCollection(),
      queryBuilder: (query) => query.where('postId', isEqualTo: postId),
      builder: (snapshotData, snapshotId) {
        return PostModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

//  Posts CRUD functions
  //  POST - Posts
  Future<Either<Failure, bool>> setPostData(PostModel postData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: postData.toMap(),
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          postsModel = postData;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  Future<Either<Failure, bool>> addPostData(PostModel postData) async {
    return await _firebaseCaller.addData(
      path: FirestorePaths.postCollection(),
      data: postData.toMap(),
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          postsModel = postData;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  //  GET - Posts
  Future<Either<Failure, PostModel?>> getPostsData(
      {required String postsId}) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.postDocument(postsId),
      builder: (data, docId) {
        if (data is! ServerFailure) {
          postsModel = data != null ? PostModel.fromMap(data, docId!) : null;
          uid = postsModel?.uId;
          return Right(postsModel);
        } else {
          return Left(data);
        }
      },
    );
  }

  //  UPDATE - Posts
  Future<Either<Failure, bool>> updatePostsData(PostModel postsData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: postsData.toMap(),
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          postsModel = postsData;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  //  GET - Posts - By Name
  Future<Either<Failure, PostModel>> getPostsDataByName(String name) async {
    return await _firebaseCaller.getCollectionData(
        path: FirestorePaths.userCollection(),
        queryBuilder: (query) => query.where('name', isEqualTo: name),
        builder: (data) async {
          if (data is! ServerFailure && data!.isNotEmpty) {
            Map<String, dynamic> userData = data.first.data();
            postsModel = PostModel.fromMap(userData, data.first.id);
            uid = postsModel?.uId;
            return Right(postsModel!);
          } else {
            log("Posts Not Found");
            final _errorMessage = Exceptions.errorMessage("Email Not Found");
            return Left(ServerFailure(message: _errorMessage));
          }
        });
  }
}
