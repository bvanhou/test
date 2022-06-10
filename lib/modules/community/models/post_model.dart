import 'package:deliverzler/auth/models/user_model.dart';

class PostModel {
  final String? uId;
  final String title;
  final String body;
  final String communityId;
  final UserModel author;
  final List<String>? votesFor;
  final List<String>? votesAgainst;
  final int? voteCount;
  final DateTime created;
  final DateTime? edited;
  final DateTime? voted;

  PostModel({
    this.uId,
    required this.title,
    required this.body,
    required this.communityId,
    required this.author,
    this.votesFor,
    this.votesAgainst,
    this.voteCount,
    required this.created,
    this.edited,
    this.voted,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'title': title,
      'body': body,
      'communityId': communityId,
      'author': author.toMap(),
      'votesFor': votesFor,
      'votesAgainst': votesAgainst,
      'voteCount': voteCount,
      'created': created,
      'edited': edited,
      'voted': voted
    }..removeWhere((key, value) => value == null);
  }

  factory PostModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PostModel(
      uId: documentId,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      communityId: map['communityId'] ?? '',
      author: map['author'],
      votesFor: map['votesFor'] ?? [],
      votesAgainst: map['votesAgainst'] ?? [],
      voteCount: map['voteCount'] ?? 0,
      created: map['created'],
      edited: map['edited'],
      voted: map['voted'],
    );
  }

  PostModel copyWith({
    String? uId,
    String? title,
    String? body,
    String? communityId,
    UserModel? author,
    List<String>? votesFor,
    List<String>? votesAgainst,
    int? voteCount,
    DateTime? created,
    DateTime? edited,
    DateTime? voted,
  }) {
    return PostModel(
        uId: uId ?? this.uId,
        title: title ?? this.title,
        body: body ?? this.body,
        communityId: communityId ?? this.communityId,
        author: author ?? this.author,
        votesFor: votesFor ?? this.votesFor,
        votesAgainst: votesAgainst ?? this.votesAgainst,
        voteCount: voteCount ?? this.voteCount,
        created: created ?? this.created,
        edited: edited ?? this.edited,
        voted: voted ?? this.voted);
  }
}
