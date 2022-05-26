class FirestorePaths {
  /// Community
  static String communityCollection() => 'communities';
  static String communityDocument(String docId) => 'communities/$docId';

  /// User
  static String userCollection() => 'users';

  static String userDocument(String docId) => 'users/$docId';

  /// Orders
  static String orderPath() => 'orders';

  static String orderById({required String orderId}) => 'orders/$orderId';

  /// FirebaseStorage
  static String profilesImagesPath(String userId) => 'users/$userId/$userId';
}
