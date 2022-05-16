class DiscordModel {
  final String code;
  final int type;
  final String expiresAt;
  final int maxAge;
  final int maxUses;
  final int uses;
  final String? invite;

  const DiscordModel(
      {required this.code,
      required this.type,
      required this.expiresAt,
      required this.maxAge,
      required this.maxUses,
      required this.uses,
      this.invite});

  factory DiscordModel.fromJson(Map<String, dynamic> json) {
    return DiscordModel(
        code: json['code'],
        type: json['type'],
        expiresAt: json['expires_at'] ?? json['expiresAt'],
        maxAge: json['max_age'] ?? json['maxAge'],
        maxUses: json['max_uses'] ?? json['maxUses'],
        uses: json['uses'],
        invite: "https://discord.gg/${json['code']}");
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'type': type,
      'expiresAt': expiresAt,
      'maxAge': maxAge,
      'maxUses': maxUses,
      'uses': uses,
      'invite': invite,
    }..removeWhere((key, value) => value == null);
  }
}
