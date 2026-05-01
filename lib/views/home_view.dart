import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/news_controller.dart';
import '../controllers/filter_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/filter_icon_button.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final NewsController controller = Get.find();
  final FilterController filterController = Get.put(FilterController());
  final RxSet<int> liked = <int>{}.obs;
  final RxSet<int> bookmarked = <int>{}.obs;
  final RxMap<int, List<String>> comments = <int, List<String>>{}.obs;

  void _showComments(BuildContext context, int index) {
    final TextEditingController commentController = TextEditingController();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.comment, color: Colors.deepPurple),
                const SizedBox(width: 8),
                const Text(
                  'Comments',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const Divider(),
            Obx(() {
              final list = comments[index] ?? [];
              return list.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No comments yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : SizedBox(
                      height: 180,
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),
                          title: Text(list[i]),
                        ),
                      ),
                    );
            }),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: () {
                    final text = commentController.text.trim();
                    if (text.isNotEmpty) {
                      comments[index] = List.from(comments[index] ?? [])
                        ..add(text);
                      commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: const [FilterIconButton()]),
      body: Stack(
        children: [
          Obx(() {
            final list = filterController.filteredNews;
            return PageView.builder(
              controller: controller.pageController,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                final news = list[index];
                return GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.detail, arguments: news),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(news.image, fit: BoxFit.cover),
                      ),
                      Positioned.fill(
                        child: Container(color: Colors.black.withOpacity(0.4)),
                      ),
                      // Enhanced Like, Share, Bookmark, Comments buttons
                      Positioned(
                        right: 20,
                        bottom: 202,
                        child: Obx(
                          () => Column(
                            children: [
                              // Like
                              GestureDetector(
                                onTap: () {
                                  if (liked.contains(index)) {
                                    liked.remove(index);
                                  } else {
                                    liked.add(index);
                                  }
                                },
                                child: Column(
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: Icon(
                                        liked.contains(index)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        key: ValueKey(liked.contains(index)),
                                        color: liked.contains(index)
                                            ? Colors.redAccent
                                            : Colors.white,
                                        size: 36,
                                        semanticLabel: 'Like',
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Like',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              // Comment
                              GestureDetector(
                                onTap: () => _showComments(context, index),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        const Icon(
                                          Icons.comment,
                                          color: Colors.white,
                                          size: 32,
                                          semanticLabel: 'Comment',
                                        ),
                                        if ((comments[index]?.length ?? 0) > 0)
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: const BoxDecoration(
                                                color: Colors.deepPurple,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                '${comments[index]?.length ?? 0}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Comment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              // Bookmark
                              GestureDetector(
                                onTap: () {
                                  if (bookmarked.contains(index)) {
                                    bookmarked.remove(index);
                                  } else {
                                    bookmarked.add(index);
                                  }
                                },
                                child: Column(
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: Icon(
                                        bookmarked.contains(index)
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        key: ValueKey(
                                          bookmarked.contains(index),
                                        ),
                                        color: bookmarked.contains(index)
                                            ? Colors.amber
                                            : Colors.white,
                                        size: 32,
                                        semanticLabel: 'Save',
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              // Share
                              GestureDetector(
                                onTap: () {
                                  Share.share(
                                    '${news.title}\n\n${news.summary}',
                                    subject: news.title,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Share dialog opened!'),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 32,
                                      semanticLabel: 'Share',
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Share',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                news.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                news.summary,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  if (news.time.isNotEmpty) ...[
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white54,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      news.time,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                  if (news.location.isNotEmpty) ...[
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white54,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      news.location,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
