class PollModel {
  final String? uId;
  final String title;
  final String description;
  final String communityId;
  final String author;
  final List<String> votesFor;
  final List<String> votesAgainst;
  final int voteCount;
  final DateTime created;
  final DateTime edited;
  final DateTime voted;

  PollModel({
    this.uId,
    required this.title,
    required this.description,
    required this.communityId,
    required this.author,
    required this.votesFor,
    required this.votesAgainst,
    required this.voteCount,
    required this.created,
    required this.edited,
    required this.voted,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'title': title,
      'description': description,
      'communityId': communityId,
      'author': author,
      'votesFor': votesFor,
      'votesAgainst': votesAgainst,
      'voteCount': voteCount,
      'created': created,
      'edited': edited,
      'voted': voted
    }..removeWhere((key, value) => value == null);
  }

  factory PollModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PollModel(
      uId: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      communityId: map['communityId'] ?? '',
      author: map['author'] ?? '',
      votesFor: map['votesFor'] ?? [],
      votesAgainst: map['votesAgainst'] ?? [],
      voteCount: map['voteCount'] ?? 0,
      created: map['created'],
      edited: map['edited'],
      voted: map['voted'],
    );
  }

  PollModel copyWith({
    String? uId,
    String? title,
    String? description,
    String? communityId,
    String? author,
    List<String>? votesFor,
    List<String>? votesAgainst,
    int? voteCount,
    DateTime? created,
    DateTime? edited,
    DateTime? voted,
  }) {
    return PollModel(
        uId: uId ?? this.uId,
        title: title ?? this.title,
        description: description ?? this.description,
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
