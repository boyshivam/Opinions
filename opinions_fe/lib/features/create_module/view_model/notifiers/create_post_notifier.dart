import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:opinions/features/create_module/enums/createPostTextFieldEnums.dart";
import "package:opinions/features/create_module/enums/post_creation_enums.dart";
import "package:opinions/features/create_module/models/create_post_model.dart";
import "package:opinions/features/create_module/view_model/providers/post_repository_manager_provider.dart";
import "package:opinions/features/create_module/view_model/state/post_state.dart";
import "package:opinions/features/create_module/repository/post_repository_manager.dart";
import "package:opinions/features/home%20screen/view_model/provider/all_posts_provider.dart";
import "package:opinions/features/home%20screen/view_model/provider/all_posts_repository_provider.dart";

class CreatePostNotifier extends Notifier<PostState> {
  @override
  build() {
    // TODO: implement build
    return PostState(
      titleFieldText: "",
      genreFieldText: "",
      contextFieldText: "",
      titleFieldState: CreatePostTextFieldEnums.neutral,
      genreFieldState: CreatePostTextFieldEnums.neutral,
      contextFieldState: CreatePostTextFieldEnums.neutral,
      postStatus: PostResponseEnums.initial,
    );
  }


  // this method to create a new post using the notifier
  Future<void> addPostData(String title, String genre, String context) async {

    final postRepository = ref.read(postRepositoryManagerProvider);

    final PostResponseEnums responseStatus = await postRepository.createAPost(
      CreatePostModel(title: title, genre: genre, context: context),
    );

    switch (responseStatus) {
      case PostResponseEnums.loading:
        state = state.copyWith(postStatus: PostResponseEnums.loading);
        break;

      case PostResponseEnums.success:
        state = state.copyWith(postStatus: PostResponseEnums.success);
        break;

      case PostResponseEnums.internalServerError:
        state = state.copyWith(
          postStatus: PostResponseEnums.internalServerError,
        );
        break;

      case PostResponseEnums.error:
        state = state.copyWith(postStatus: PostResponseEnums.error);
        break;

      default:
        break;
    }
  }


  // this method will edit and update an existing post
  Future<void> updatePostData(
    String title,
    String genre,
    String context,
      int postId
  ) async {

    final postRepositoryProvider = ref.read(postRepositoryManagerProvider);

    final allPostsNotifier = ref.read(allPostsProvider.notifier);

    final response = await postRepositoryProvider.editPost(title, genre, context, postId);


    switch(response) {
      case PostResponseEnums.loading:
        state = state.copyWith(postStatus: PostResponseEnums.loading);
        break;

      case PostResponseEnums.success:
        state = state.copyWith(postStatus: PostResponseEnums.success);
        allPostsNotifier.refreshPosts();
        break;

      case PostResponseEnums.internalServerError:
        state = state.copyWith(
          postStatus: PostResponseEnums.internalServerError,
        );
        break;

      case PostResponseEnums.error:
        state = state.copyWith(postStatus: PostResponseEnums.error);
        break;

      default:
        break;

    }

  }
}
