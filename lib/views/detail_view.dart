import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../models/news_model.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/watermark_util.dart';
import '../controllers/news_controller.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsModel? news = Get.arguments as NewsModel?;
    if (news == null) {
      // Redirect to home if no news data is provided
      Future.microtask(() => Get.offAllNamed('/'));
      return const SizedBox.shrink();
    }
    final NewsController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.deepPurple),
        title: const Text(
          'INEWS',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {
              Share.share(
                '${news.title}\n\n${news.description}',
                subject: news.title,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: watermarkedImage(news.image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8,
                  ),
                  child: Text(
                    news.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        news.time,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        news.location,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(
                    () => AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: controller.showSummary.value
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: Text(
                        news.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      secondChild: Text(
                        news.aiSummary ?? 'No summary available.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Mute/Unmute floating button
          Positioned(
            right: 20,
            top: 20,
            child: Obx(
              () => FloatingActionButton(
                heroTag: 'mute_detail',
                mini: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: controller.toggleMute,
                child: Icon(
                  controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                  color: const Color.fromARGB(255, 218, 214, 214),
                ),
                tooltip: controller.isMuted.value ? 'Unmute' : 'Mute',
              ),
            ),
          ),
          // Summary toggle button
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Center(
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => controller.showSummary.value = false,
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu_book,
                              color: controller.showSummary.value
                                  ? Colors.grey
                                  : Colors.deepPurple,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Full',
                              style: TextStyle(
                                color: controller.showSummary.value
                                    ? Colors.grey
                                    : Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => controller.showSummary.value = true,
                        child: Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: controller.showSummary.value
                                  ? Colors.deepPurple
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Summary',
                              style: TextStyle(
                                color: controller.showSummary.value
                                    ? Colors.deepPurple
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 