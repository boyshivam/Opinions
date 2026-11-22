import "dart:convert";

import "package:http/http.dart" as http;
import "package:opinions/features/home%20screen/models/fetched_post_model.dart";
import "package:opinions/features/registration/repository/services/token_storge_service.dart";

class AllPostsRepository {
  const AllPostsRepository({required this.client});

  final http.Client client;


  // Fetch all existing posts from BE
  Future<List<FetchedPostModel>> fetchAllPosts() async {

    final url = Uri.parse("http://10.0.2.2:8000/post/");

    final tokenStorage = TokenStorgeService();

    final  token = await tokenStorage.fetchToken();


    if (token == null || token.isEmpty){
      throw Exception("Authorization token not found");
    }

    final http.Response response = await client.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );



    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);


      print(data);
      return data.map((post) => FetchedPostModel.fromJson(post)).toList();
    }
    throw Exception("${response.body} , ${response.statusCode}");

  }


  //





}