import 'package:opinions/features/home%20screen/models/fetched_post_model.dart';

class CreateScreenExtras {
  const CreateScreenExtras({
    required this.editMode,
     required this.sharedPost});

  final bool editMode;
  final FetchedPostModel? sharedPost;
}
