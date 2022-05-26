class CommunityModel {
  final String uId;
  final String? name;
  final String? image;
  late final int? shares;
  late final int? members;
  late final int? nonMembers;

  CommunityModel({
    required this.uId,
    required this.name,
    required this.image,
    this.shares,
    this.members,
    this.nonMembers,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name ?? '',
      'image': image ?? '',
      'shares': shares ?? 0,
      'members': members ?? 0,
      'nonMembers': nonMembers ?? 0,
    }..removeWhere((key, value) => value == null);
  }

  factory CommunityModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CommunityModel(
      uId: documentId,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      shares: map['shares'] ?? 0,
      members: map['members'] ?? 0,
      nonMembers: map['nonMembers'] ?? 0,
    );
  }

  CommunityModel copyWith({
    String? uId,
    String? name,
    int? shares,
    int? members,
    int? nonMembers,
  }) {
    return CommunityModel(
      uId: uId ?? this.uId,
      name: name ?? this.name,
      image: image ?? image,
      shares: shares ?? this.shares,
      members: members ?? this.members,
      nonMembers: nonMembers ?? this.nonMembers,
    );
  }
}
