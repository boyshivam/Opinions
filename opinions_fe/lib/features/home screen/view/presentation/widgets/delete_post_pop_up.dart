import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:opinions/features/create_module/view_model/providers/create_post_provider.dart";

class DeletePostPopUp extends ConsumerWidget {
  const DeletePostPopUp({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Center(child: Text("Confirm deletion of post")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure to delete the post ?"),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text("No"),
              ),
              ElevatedButton(
                onPressed: () {
                  final postManager = ref.read(createPostProvider.notifier);
                  postManager.deletePost(postId);
                  context.pop();
                },
                child: Text("Yes"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
