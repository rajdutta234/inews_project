import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/filter_controller.dart';
import '../views/filter_bottom_sheet.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = Get.find<FilterController>();
    return Obx(() {
      final isActive =
          filter.selectedCategory.value != 'All' ||
          filter.selectedLocation.value != 'India' ||
          filter.selectedTimeFrame.value != 'Today';
      return Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter',
            onPressed: () {
              Get.bottomSheet(
                const FilterBottomSheet(),
                isScrollControlled: true,
              );
            },
          ),
          if (isActive)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      );
    });
  }
}
