import 'package:deliverzler/modules/community/models/post_model.dart';
import 'package:deliverzler/modules/community/repos/posts_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final communityPostStreamProvider =
    StreamProvider.family<List<PostModel>, String>((ref, id) {
  return ref.watch(postRepoProvider).getPostsStream(communityId: id);
});

final postCommentStreamProvider =
    StreamProvider.family<List<PostModel>, String>((ref, id) {
  return ref.watch(postRepoProvider).getCommentStream(postId: id);
});
