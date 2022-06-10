import 'package:deliverzler/modules/community/models/community_model.dart';
import 'package:deliverzler/modules/community/repos/community_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainCommunityStreamProvider = StreamProvider<List<CommunityModel>>((ref) {
  return ref.watch(communityRepoProvider).getMainCommunityStream();
});

final communityListStreamProvider = StreamProvider<List<CommunityModel>>((ref) {
  return ref.watch(communityRepoProvider).getCommunityListStream();
});

final communityStreamProvider =
    StreamProvider.family<List<CommunityModel>, String>((ref, id) {
  return ref.watch(communityRepoProvider).getCommunityStream(communityId: id);
});
