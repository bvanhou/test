class FirestorePaths {
  /// Community
  static String communityCollection() => 'communities';
  static String communityDocument(String docId) => 'communities/$docId';

  /// User
  static String userCollection() => 'users';
  static String userDocument(String docId) => 'users/$docId';

  /// Post
  static String postCollection() => 'posts';
  static String postDocument(String docId) => 'posts/$docId';

  /// Comment
  static String commentCollection() => 'comments';
  static String commentDocument(String docId) => 'comments/$docId';

  /// Orders
  static String orderPath() => 'orders';
  static String orderById({required String orderId}) => 'orders/$orderId';

  /// FirebaseStorage
  static String profilesImagesPath(String userId) => 'users/$userId/$userId';
}
