import "package:opinions/features/home%20screen/view/presentation/widgets/posts_viewer.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:opinions/features/home%20screen/view_model/provider/all_posts_provider.dart";
import "package:flutter/material.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  late TextEditingController titleController;
  late TextEditingController genreController;
  late TextEditingController contextController;


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      Future.microtask((){
        ref.invalidate(allPostsProvider);
      });
      titleController = TextEditingController();
      contextController = TextEditingController();
      genreController = TextEditingController();
    }


    @override
      void dispose() {
        // TODO: implement dispose
        super.dispose();
        titleController.dispose();
        contextController.dispose();
        genreController.dispose();
      }

  @override
  Widget build(BuildContext context) {
    final allPosts = ref.watch(allPostsProvider);

    final allPostsNotifier = ref.read(allPostsProvider.notifier);


    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: allPosts.when(
        loading: () => Center(child: CircularProgressIndicator()),

        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: TextStyle(color: Colors.white)),
        ),

        data: (posts) {
          return RefreshIndicator(
            onRefresh: () async {

              await allPostsNotifier.refreshPosts();

            },
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFf5f6f7),
                    Color(0xFFe8d8f2),
                    Color(0xFFf5f6f7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        25,
                        MediaQuery.of(context).padding.top + 12,
                        25,
                        20,
                      ),
                      child: Column(
                        children: [
                          // header section
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.menu),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Opinions",
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      decoration: TextDecoration.none,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // posts
                          PostsViewer(
                            posts: posts,
                            parentHeight: constraints.maxHeight,
                            titleController: titleController,
                            contextController: contextController,
                            genreController: genreController,

                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
