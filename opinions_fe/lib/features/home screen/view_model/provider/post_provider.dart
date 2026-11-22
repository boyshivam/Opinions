import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opinions/features/home%20screen/view_model/notifier/post_notifier.dart';

final postProvider = NotifierProvider<PostNotifier, dynamic>(() {
  return PostNotifier();
});
