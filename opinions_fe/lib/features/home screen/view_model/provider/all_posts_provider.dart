import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opinions/features/home%20screen/models/fetched_post_model.dart';
import 'package:opinions/features/home%20screen/view_model/notifier/all_posts_notifier.dart';

final allPostsProvider =
    AsyncNotifierProvider<AllPostsNotifier, List<FetchedPostModel>>(
      AllPostsNotifier.new,
    );
