import "package:flutter/material.dart";
import "package:opinions/features/home%20screen/models/fetched_post_model.dart";
import "package:opinions/features/home%20screen/view/presentation/widgets/post.dart";

class PostsViewer extends StatelessWidget {
  const PostsViewer({
    super.key,
    required this.posts,
    required this.parentHeight,
    required this.titleController,
    required this.genreController,
    required this.contextController,
  });

  final List<FetchedPostModel> posts;
  final double parentHeight;
  final TextEditingController titleController;
  final TextEditingController genreController;
  final TextEditingController contextController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: parentHeight,
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) => Post(
          post: posts[index],
          titleController: titleController,
          genreController: genreController,
          contextController: contextController,
        ),
      ),
    );
  }
}
