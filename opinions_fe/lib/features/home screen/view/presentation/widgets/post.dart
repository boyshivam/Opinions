import "package:opinions/core/utils/helpers/local_time_zone_helper.dart";
import "package:opinions/features/home%20screen/models/fetched_post_model.dart";
import "package:material_ui/material_ui.dart";

class Post extends StatelessWidget {
  const Post({super.key, required this.post});

  final FetchedPostModel post;

  @override
  Widget build(BuildContext context) {
    // DateTime now = post.createdAt;
    // String formattedDate = DateFormat('HH:mm dd:MM:yyyy').format(now);

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
            Text(post.responseModel.title),
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
