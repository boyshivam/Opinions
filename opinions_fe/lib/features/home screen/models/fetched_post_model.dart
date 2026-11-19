import 'package:opinions/features/home%20screen/models/post_response_model.dart';

class FetchedPostModel {
  const FetchedPostModel({required this.responseModel, required this.votes, required this.userName});

  final PostResponseModel responseModel;
  final int votes;
  final String userName;

  factory FetchedPostModel.fromJson(Map<dynamic, dynamic> json) {

    print(json['post']['title']);
    print(json['post']['genre']);
    print(json['post']['created_at']);
    print(json['post']['context']);
    print(json['vote']);
    print(json['username']);



    return FetchedPostModel(

      responseModel: PostResponseModel.fromJson(json['post']),
      votes: json['vote'],
      userName: json['username']
    );
  }
}
