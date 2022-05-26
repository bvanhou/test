import 'package:deliverzler/auth/models/discord_model.dart';
import 'package:deliverzler/auth/models/phone_number_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uId;
  final String email;
  String username;
  late final PhoneNumberModel? phone;
  final String? image;
  final bool approved;

  late final bool? banned;
  late final bool? hasApplied;
  bool? phoneVerified;

  final String? drsImage;

  late final num? attempts;
  late final num? approvals;
  late final num? denialRate;

  late final List<String>? approvalHistory;
  late final List<String>? rejectedHistory;

  late final DiscordModel? discord;

  UserModel(
      {required this.uId,
      required this.email,
      required this.username,
      required this.phone,
      required this.image,
      required this.approved,
      required this.banned,
      required this.hasApplied,
      required this.phoneVerified,
      this.drsImage,
      this.approvalHistory,
      this.rejectedHistory,
      this.attempts,
      this.approvals,
      this.denialRate,
      this.discord});

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
      'username': username,
      'phone': phone!.toMap(),
      'image': image ?? '',
      'approved': approved,
      'banned': banned ?? false,
      'hasApplied': hasApplied ?? false,
      'phoneVerified': phoneVerified ?? false,
      'drsImage': drsImage ?? '',
      'denialRate': denialRate ?? 0,
      'attempts': attempts ?? 0,
      'approvals': approvals ?? 0,
      'approvalHistory': approvalHistory ?? [],
      'rejectedHistory': rejectedHistory ?? [],
      'discord': discord,
    }..removeWhere((key, value) => value == null);
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    final _aHistory = (map['approvalHistory'] != null)
        ? map['approvalHistory'].cast<String>()
        : <String>[];
    final _rHistory = (map['rejectedHistory'] != null)
        ? map['rejectedHistory'].cast<String>()
        : <String>[];

    return UserModel(
      uId: documentId,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: (map['phone'] != null)
          ? PhoneNumberModel.fromMap(map['phone'])
          : null,
      image: map['image'] ?? '',
      drsImage: map['drsImage'] ?? '',
      phoneVerified: map['phoneVerified'] ?? false,
      approved: map['approved'] ?? '',
      banned: map['banned'] ?? false,
      hasApplied: map['hasApplied'] ?? false,
      denialRate: map['denialRate'] ?? 0,
      attempts: map['attempts'] ?? 0,
      approvals: map['approvals'] ?? 0,
      approvalHistory: _aHistory,
      rejectedHistory: _rHistory,
      discord: (map['discord'] != null)
          ? DiscordModel.fromJson(map['discord'])
          : null,
    );
  }

  /// Google Factory
  factory UserModel.fromUserCredential(User user) {
    PhoneNumberModel _mobile = user.phoneNumber != null
        ? PhoneNumberModel.fromMap(
            {"phoneNumber": user.phoneNumber, "isoCode": "", "dialCode": ""})
        : const PhoneNumberModel(phoneNumber: "", isoCode: "", dialCode: "");
    return UserModel(
        uId: user.uid,
        email: user.email ?? '',
        username: user.displayName?.split(' ').first ?? '',
        phone: _mobile,
        image: user.photoURL ?? '',
        phoneVerified: user.phoneNumber!.isNotEmpty || false,
        approved: false,
        banned: false,
        hasApplied: false,
        denialRate: 0,
        approvalHistory: [],
        rejectedHistory: []);
  }

  UserModel copyWith(
      {String? uId,
      String? username,
      String? email,
      String? image,
      PhoneNumberModel? phone,
      String? drsImage,
      bool? phoneVerified,
      bool? hasApplied,
      bool? approved,
      bool? banned,
      num? denialRate,
      num? attempts,
      num? approvals,
      List<String>? approvalHistory,
      List<String>? rejectedHistory,
      DiscordModel? discord}) {
    return UserModel(
        uId: uId ?? this.uId,
        username: username ?? this.username,
        email: email ?? this.email,
        image: image ?? this.image,
        phone: phone ?? this.phone,
        drsImage: drsImage ?? this.drsImage,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        hasApplied: hasApplied ?? this.hasApplied,
        approved: approved ?? this.approved,
        banned: banned ?? this.banned,
        approvals: approvals ?? this.approvals,
        attempts: attempts ?? this.attempts,
        denialRate: denialRate ?? this.denialRate,
        approvalHistory: approvalHistory ?? this.approvalHistory,
        discord: discord ?? this.discord);
  }
}
