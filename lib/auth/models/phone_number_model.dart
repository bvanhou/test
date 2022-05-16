class PhoneNumberModel {
  final String phoneNumber;
  final String isoCode;
  final String dialCode;

  const PhoneNumberModel(
      {required this.phoneNumber,
      required this.isoCode,
      required this.dialCode});

  factory PhoneNumberModel.fromMap(Map<String, dynamic> json) {
    return PhoneNumberModel(
        phoneNumber: json['phoneNumber'],
        isoCode: json['isoCode'],
        dialCode: json['dialCode']);
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'isoCode': isoCode,
      'dialCode': dialCode,
    }..removeWhere((key, value) => value == null);
  }
}
