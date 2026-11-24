import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:opinions/features/create_module/enums/post_creation_enums.dart';
import 'package:opinions/features/create_module/view_model/providers/create_post_provider.dart';
import 'package:opinions/features/home%20screen/models/fetched_post_model.dart';
import 'package:opinions/router/routes.dart';
import 'package:opinions/utils/helper_functions/common_header.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key, this.editMode = false, this.sharedPost});

  final bool editMode;
  final FetchedPostModel? sharedPost;

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  // declare text controller to derive values
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController genreTextController = TextEditingController();
  final TextEditingController contextTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.editMode == true && widget.sharedPost != null) {
      titleTextController.text = widget.sharedPost!.responseModel.title;
      genreTextController.text = widget.sharedPost!.responseModel.genre;
      contextTextController.text = widget.sharedPost!.responseModel.context;
    }
  }

  @override
  Widget build(BuildContext context) {
    final editMode = widget.editMode;
    final post = widget.sharedPost;

    ref.listen(createPostProvider, ((previous, next) async {
      switch (next.postStatus) {
        // snack bar msg for success post creation
        case PostResponseEnums.success:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                editMode == true
                    ? "Post edited successfully!"
                    : "Post created successfully!",
              ),
              duration: Duration(seconds: 2),
            ),
          );

          context.go(AppRoutes.homeScreen);
          break;

        // pop up dialogue for error response
        case PostResponseEnums.error:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(
                  editMode
                      ? "Post could not be edited! Try again."
                      : "Post could not be created! Try again.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
          break;


        case PostResponseEnums.unauthorized:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(
                  "Unauthorized access",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
          break;


        case PostResponseEnums.notFound:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(
                  "Post not found by the requested id ${post!.responseModel.postId}",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
          break;

        case PostResponseEnums.internalServerError:
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Internal server error"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
          break;

        case PostResponseEnums.loading:
          CircularProgressIndicator();
          break;

        default:
          break;
      }
    }));

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, builder) {
          Widget currentScreen = SingleChildScrollView(
            child: Column(
              children: [
                CommonHeader(headerText: editMode ? "Edit post" : "Add a post"),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              editMode
                                  ? "Edit your post"
                                  : "Title of your post",
                            ),
                            TextFormField(
                              controller: titleTextController,
                              maxLength: 30,
                              decoration: InputDecoration(counterText: ""),
                              validator: (value) {
                                if (value == null) {
                                  return "Value cannot be null";
                                }
                                if (value.trim().isEmpty) {
                                  return "Title cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Text(editMode ? "Edit genre" : "Name a genre"),
                            TextFormField(
                              controller: genreTextController,
                              maxLength: 30,
                              decoration: InputDecoration(counterText: ""),
                              validator: (value) {
                                if (value == null) {
                                  return "Value cannot be null";
                                }
                                if (value.trim().isEmpty) {
                                  return "genre cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              editMode
                                  ? "Edit your view"
                                  : "Elaborate on your view",
                            ),
                            TextFormField(
                              controller: contextTextController,
                              maxLength: 30,
                              decoration: InputDecoration(counterText: ""),
                              validator: (value) {
                                if (value == null) {
                                  return "Value cannot be null";
                                }
                                if (value.trim().isEmpty) {
                                  return "Context cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // cancel button to navigate to previous screen
                            ElevatedButton(
                              onPressed: () {
                                context.pop();
                                // editMode
                                //     ? context.pop()
                                //     : context.go(AppRoutes.loginScreen);
                              },
                              child: Text("Cancel"),
                            ),
                            const SizedBox(width: 20),

                            // submit button for post in create and edit mode
                            ElevatedButton(
                              onPressed: () {
                                final createPostNotifier = ref.read(
                                  createPostProvider.notifier,
                                );

                                if (editMode == false) {
                                  if (_formKey.currentState!.validate()) {
                                    createPostNotifier.addPostData(
                                      titleTextController.text,
                                      genreTextController.text,
                                      contextTextController.text,
                                    );
                                  }
                                }
                                if (editMode == true) {
                                  if (_formKey.currentState!.validate()) {
                                    createPostNotifier.updatePostData(
                                      titleTextController.text,
                                      genreTextController.text,
                                      contextTextController.text,
                                      post!.responseModel.postId,
                                    );
                                  }
                                }
                              },
                              child: Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          return currentScreen;
        },
      ),
    );
  }
}
