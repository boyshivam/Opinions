import "package:http/http.dart" as http;
import "package:opinions/features/create_module/enums/post_creation_enums.dart";
import "package:opinions/features/create_module/models/create_post_model.dart";

import 'dart:convert';

import "package:opinions/features/registration/repository/services/token_storge_service.dart";

class PostRepositoryManager {
  PostRepositoryManager({required this.client, required this.tokenStorage});

  final http.Client client;
  final TokenStorgeService tokenStorage;

  // add new post to db
  Future<PostResponseEnums> createAPost(CreatePostModel post) async {
    final url = Uri.parse('http://10.0.2.2:8000/post/');

    final fetchedToken = await tokenStorage.fetchToken();

    if (fetchedToken == null || fetchedToken.isEmpty) {
      throw Exception("Token does not exist");
    }

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $fetchedToken",
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': post.title,
        'context': post.context,
        'genre': post.genre,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PostResponseEnums.success;
    } else if (response.statusCode == 500) {
      return PostResponseEnums.internalServerError;
    } else if (response.statusCode == 401) {
      return PostResponseEnums.unauthorized;
    } else if (response.statusCode == 404) {
      return PostResponseEnums.notFound;
    } else {
      return PostResponseEnums.error;
    }
  }

  // Edit an existing post in db
  Future<PostResponseEnums> editPost(
    String title,
    String genre,
    String context,
    int postId,
  ) async {
    final url = Uri.parse("http://10.0.2.2:8000/post/$postId");

    // access token from token storage
    final fetchedToken = await tokenStorage.fetchToken();

    final http.Response response = await client.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $fetchedToken",
      },
      body: jsonEncode({"title": title, "genre": genre, "context": context}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PostResponseEnums.success;
    }
    if (response.statusCode == 500) {
      return PostResponseEnums.internalServerError;
    }
    if (response.statusCode == 401) {
      return PostResponseEnums.unauthorized;
    }
    if (response.statusCode == 404) {
      return PostResponseEnums.notFound;
    }

    return PostResponseEnums.timeOut;
  }

  // delete an existing post
  Future<PostResponseEnums> deletePost(int postId) async {

    final url = Uri.parse("http://10.0.2.2:8000/post/$postId");

    final client = http.Client();


    final fetchedToken = await tokenStorage.fetchToken();

    final http.Response response = await client.delete(
      url,
      headers: {
        "Authorization": "Bearer $fetchedToken",
        "Content-Type": "application/json",
      },
    );


    if (response.statusCode == 200) {
      return PostResponseEnums.success;
    } else if (response.statusCode == 401) {
      return PostResponseEnums.unauthorized;
    } else if (response.statusCode == 404) {
      return PostResponseEnums.notFound;
    } else if (response.statusCode == 500) {
      return PostResponseEnums.unauthorized;
    } else {
      PostResponseEnums.error;
    }
    return PostResponseEnums.timeOut;
  }
}
