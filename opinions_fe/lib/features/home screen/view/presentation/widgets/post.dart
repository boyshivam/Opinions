import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:opinions/core/utils/helpers/local_time_zone_helper.dart";
import "package:opinions/features/create_module/route_extras/create_screen_extras.dart";
import "package:opinions/features/home%20screen/models/fetched_post_model.dart";
import "package:flutter/material.dart";
import "package:opinions/features/home%20screen/view/presentation/widgets/delete_post_pop_up.dart";
import "package:opinions/router/routes.dart";
import "package:go_router/go_router.dart";

class Post extends ConsumerWidget {
  const Post({
    super.key,
    required this.post,
    required this.titleController,
    required this.genreController,
    required this.contextController,
  });

  final FetchedPostModel post;
  final TextEditingController titleController;
  final TextEditingController genreController;
  final TextEditingController contextController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final postId = post.responseModel.postId;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.white, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        post.responseModel.title,
                        style: TextStyle(fontSize: 28),
                      ),
                      Positioned(
                        right: 0,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              context.push(
                                AppRoutes.createScreen,
                                extra: CreateScreenExtras(
                                  editMode: true,
                                  sharedPost: post,
                                ),
                              );
                            }
                            if (value == "delete") {
                              showDialog(
                                context: context,
                                builder: (context) {



                                  return DeletePostPopUp(postId: postId,);
                                },
                              );
                            }
                          },
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "edit",
                              child: Text("Edit post"),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: Text("Delete post"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(post.userName),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.responseModel.genre,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text(
                  LocalTimeZoneHelper.convertToLocalTZ(
                    post.responseModel.dateTime,
                  ),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              post.responseModel.context,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
