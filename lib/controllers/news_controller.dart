import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/news_model.dart';
import 'dart:async';

class NewsController extends GetxController {
  var newsList = <NewsModel>[
    NewsModel(
      title: 'Flutter 3.0 Released',
      image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      description:
          'Flutter 3.0 brings new features and improvements for cross-platform development.',
      time: '2h ago',
      location: 'Delhi',
      summary:
          'Flutter 3.0 is out now with exciting new features for developers.',
      category: 'Tech',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      aiSummary:
          'Flutter 3.0 is released with major cross-platform improvements. Developers can now build faster and more efficiently. (AI summary)',
    ),
    NewsModel(
      title: 'Dart 2.17 Announced',
      image: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      description:
          'Dart 2.17 focuses on performance and language improvements.',
      time: '4h ago',
      location: 'Mumbai',
      summary:
          'Dart 2.17 is now available with better performance and new language features.',
      category: 'Tech',
      dateTime: DateTime.now().subtract(const Duration(hours: 4)),
      aiSummary:
          'Dart 2.17 brings performance and language improvements for developers. (AI summary)',
    ),
    NewsModel(
      title: 'Elections 2025: Results Announced',
      image: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      description: 'The 2025 elections have concluded with surprising results.',
      time: '1d ago',
      location: 'Chennai',
      summary: 'Election results are out, with major upsets in key states.',
      category: 'Politics',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      aiSummary:
          '2025 elections concluded with surprising results and upsets in key states. (AI summary)',
    ),
    NewsModel(
      title: 'IPL 2025: Mumbai Wins Final',
      image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      description: 'Mumbai clinched the IPL 2025 trophy in a thrilling final.',
      time: '3d ago',
      location: 'Mumbai',
      summary: 'Mumbai wins IPL 2025 after a nail-biting finish.',
      category: 'Sports',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      aiSummary:
          'Mumbai wins IPL 2025 in a thrilling final match. (AI summary)',
    ),
    NewsModel(
      title: 'Bollywood Blockbuster Released',
      image: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      description: 'A new Bollywood movie is breaking box office records.',
      time: 'Today',
      location: 'Delhi',
      summary: 'The latest Bollywood blockbuster is a must-watch.',
      category: 'Entertainment',
      dateTime: DateTime.now(),
      aiSummary:
          'A new Bollywood blockbuster is breaking box office records. (AI summary)',
    ),
  ].obs;

  var searchResults = <NewsModel>[].obs;

  // AI summary toggle
  var showSummary = false.obs;

  // Sound control only
  var isMuted = true.obs;
  var currentPage = 0.obs;
  late PageController pageController;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    ever(isMuted, (_) => _handleTTS());
    ever(currentPage, (_) => _handleTTS());
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    _handleTTS();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    _handleTTS();
  }

  void _handleTTS() async {
    await flutterTts.stop();
    if (!isMuted.value && currentPage.value < newsList.length) {
      final news = newsList[currentPage.value];
      await flutterTts.speak(news.description);
    }
  }

  void searchNews(String query) {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }
    final lower = query.toLowerCase();
    searchResults.value = newsList
        .where(
          (news) =>
              news.title.toLowerCase().contains(lower) ||
              news.summary.toLowerCase().contains(lower),
        )
        .toList();
  }

  void clearSearch() {
    searchResults.clear();
  }

  var selectedCategory = ''.obs;
}
 