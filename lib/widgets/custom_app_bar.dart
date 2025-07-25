import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../controllers/news_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSettings;
  final bool showSearch;
  final bool showBack;
  final VoidCallback? onSettings;
  final VoidCallback? onSearch;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.title = 'INEWS',
    this.showSettings = true,
    this.showSearch = true,
    this.showBack = false,
    this.onSettings,
    this.onSearch,
    this.onBack,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return _CustomAppBarBody(
      title: title,
      showSettings: showSettings,
      showSearch: showSearch,
      showBack: showBack,
      onSettings: onSettings,
      onSearch: onSearch,
      onBack: onBack,
      actions: actions,
    );
  }
}

class _CustomAppBarBody extends StatefulWidget {
  final String title;
  final bool showSettings;
  final bool showSearch;
  final bool showBack;
  final VoidCallback? onSettings;
  final VoidCallback? onSearch;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const _CustomAppBarBody({
    required this.title,
    required this.showSettings,
    required this.showSearch,
    required this.showBack,
    this.onSettings,
    this.onSearch,
    this.onBack,
    this.actions,
  });

  @override
  State<_CustomAppBarBody> createState() => _CustomAppBarBodyState();
}

class _CustomAppBarBodyState extends State<_CustomAppBarBody> {
  bool _searchMode = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _searchMode) {
        setState(() => _searchMode = false);
        _searchController.clear();
      }
    });
  }

  void _handleSettings() {
    if (Get.currentRoute == AppRoutes.settings) {
      Get.snackbar(
        'Settings',
        'You are already on the Settings page.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.toNamed(AppRoutes.settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();
    return AppBar(
      leading: widget.showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: widget.onBack ?? () => Get.back(),
            )
          : widget.showSettings
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: widget.onSettings ?? _handleSettings,
            )
          : null,
      title: const Text(
        'INEWS',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      centerTitle: true,
      actions: [
        if (widget.showSearch)
          _searchMode
              ? Container(
                  width: 165,
                  margin: const EdgeInsets.only(right: 8),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    autofocus: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() => _searchMode = false);
                          _searchController.clear();
                          newsController.clearSearch();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      newsController.searchNews(value);
                    },
                    onSubmitted: (value) {
                      setState(() => _searchMode = false);
                      newsController.searchNews(value);
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() => _searchMode = true);
                    },
                  ),
                ),
        if (widget.actions != null) ...widget.actions!,
      ],
      elevation: 2,
      backgroundColor: Colors.white,
      foregroundColor: Colors.deepPurple,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
