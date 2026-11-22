import 'package:opinions/features/home%20screen/enums/delete_post_status_enums.dart';
import 'package:opinions/features/home%20screen/enums/edit_post_status_enums.dart';

class PostState {
  const PostState({required this.editButton, required this.deleteButton});

  final EditPostStatusEnums editButton;
  final DeletePostStatusEnums deleteButton;

  PostState copyWith({
    EditPostStatusEnums? editButton,
    DeletePostStatusEnums? deleteButton,
  }) {
    return PostState(
      editButton: editButton ?? this.editButton,
      deleteButton: deleteButton ?? this.deleteButton,
    );
  }
}
