import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opinions/features/home%20screen/models/fetched_post_model.dart';
import 'package:opinions/features/home%20screen/view_model/provider/all_posts_repository_provider.dart';

class AllPostsNotifier extends AsyncNotifier<List<FetchedPostModel>> {
  @override
  FutureOr<List<FetchedPostModel>> build() async {
    final allPostsRepository = ref.read(allPostsRepositoryProvider);

    return allPostsRepository.fetchAllPosts();
  }

  Future<void> refreshPosts() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      final allPostsRepository = ref.read(allPostsRepositoryProvider);
      return allPostsRepository.fetchAllPosts();
    });
  }
}
