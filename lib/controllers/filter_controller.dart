import 'package:get/get.dart';
import '../models/news_model.dart';
import 'news_controller.dart';

class FilterController extends GetxController {
  var selectedCategory = 'All'.obs;
  var selectedLocation = 'India'.obs;
  var selectedTimeFrame = 'Today'.obs;

  List<String> categories = [
    'All',
    'Tech',
    'Politics',
    'Sports',
    'Entertainment',
  ];
  List<String> locations = ['India', 'Delhi', 'Mumbai', 'Bangalore', 'Chennai'];
  List<String> timeFrames = ['Today', 'This Week', 'Past 24 hrs', 'Trending'];

  List<NewsModel> get filteredNews {
    final allNews = Get.find<NewsController>().newsList;
    return allNews.where((news) {
      final matchesCategory =
          selectedCategory.value == 'All' ||
          (news.category ?? 'All') == selectedCategory.value;
      final matchesLocation =
          selectedLocation.value == 'India' ||
          news.location == selectedLocation.value;
      final matchesTime = filterByTime(news.dateTime);
      return matchesCategory && matchesLocation && matchesTime;
    }).toList();
  }

  bool filterByTime(DateTime? time) {
    if (time == null) return true;
    final now = DateTime.now();
    if (selectedTimeFrame.value == 'Today') {
      return time.year == now.year &&
          time.month == now.month &&
          time.day == now.day;
    } else if (selectedTimeFrame.value == 'This Week') {
      return time.isAfter(now.subtract(const Duration(days: 7)));
    } else if (selectedTimeFrame.value == 'Past 24 hrs') {
      return time.isAfter(now.subtract(const Duration(hours: 24)));
    } else if (selectedTimeFrame.value == 'Trending') {
      return true; // Placeholder for trending logic
    }
    return true;
  }

  void resetFilters() {
    selectedCategory.value = 'All';
    selectedLocation.value = 'India';
    selectedTimeFrame.value = 'Today';
  }
}
