import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:deliverzler/auth/repos/user_repo.dart';
import 'package:deliverzler/modules/community/models/community_model.dart';
import 'package:deliverzler/core/errors/exceptions.dart';
import 'package:deliverzler/core/errors/failures.dart';
import 'package:deliverzler/core/services/firebase_services/firebase_caller.dart';
import 'package:deliverzler/core/services/firebase_services/firestore_paths.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final communityRepoProvider =
    Provider<CommunityRepo>((ref) => CommunityRepo(ref));

class CommunityRepo {
  CommunityRepo(this.ref) {
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  late String? uid;

  late UserRepo _userRepo;
  final FirebaseCaller _firebaseCaller = FirebaseCaller.instance;
  late CommunityModel? communityModel;

//  GET - Main Community - Stream
  Stream<List<CommunityModel>> getMainCommunityStream() {
    return _firebaseCaller.collectionStream<CommunityModel>(
      path: FirestorePaths.communityCollection(),
      queryBuilder: (query) => query.where('name', isEqualTo: 'beyondthemoon'),
      builder: (snapshotData, snapshotId) {
        return CommunityModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  Stream<List<CommunityModel>> getCommunityListStream() {
    return _firebaseCaller.collectionStream<CommunityModel>(
      path: FirestorePaths.communityCollection(),
      // queryBuilder: (query) =>
      //     query.where('name', isNotEqualTo: 'beyondthemoon'),
      builder: (snapshotData, snapshotId) {
        return CommunityModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  Stream<List<CommunityModel>> getCommunityStream(
      {required String communityId}) {
    return _firebaseCaller.collectionStream<CommunityModel>(
      path: FirestorePaths.communityCollection(),
      queryBuilder: (query) => query.where('id', isEqualTo: communityId),
      builder: (snapshotData, snapshotId) {
        return CommunityModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

//  Community CRUD functions
  //  POST - Community
  Future<Either<Failure, bool>> setCommunityData(
      CommunityModel communityData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.communityDocument(communityData.uId),
      data: communityData.toMap(),
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          communityModel = data;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  //  GET - Community
  Future<Either<Failure, CommunityModel?>> getCommunityData(
      {required String communityId}) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.communityDocument(communityId),
      builder: (data, docId) {
        if (data is! ServerFailure) {
          communityModel =
              data != null ? CommunityModel.fromMap(data, docId!) : null;
          uid = communityModel?.uId;
          return Right(communityModel);
        } else {
          return Left(data);
        }
      },
    );
  }

  //  UPDATE - Community
  Future<Either<Failure, bool>> updateCommunityData(
      CommunityModel communityData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: communityData.toMap(),
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          communityModel = communityData;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  //  GET - Community - By Name
  Future<Either<Failure, CommunityModel>> getCommunityDataByName(
      String name) async {
    return await _firebaseCaller.getCollectionData(
        path: FirestorePaths.userCollection(),
        queryBuilder: (query) => query.where('name', isEqualTo: name),
        builder: (data) async {
          if (data is! ServerFailure && data!.isNotEmpty) {
            Map<String, dynamic> userData = data.first.data();
            communityModel = CommunityModel.fromMap(userData, data.first.id);
            uid = communityModel?.uId;
            return Right(communityModel!);
          } else {
            log("Community Not Found");
            final _errorMessage = Exceptions.errorMessage("Email Not Found");
            return Left(ServerFailure(message: _errorMessage));
          }
        });
  }
}
