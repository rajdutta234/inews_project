import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/filter_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = Get.find<FilterController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter News',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20),
          const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Obx(
            () => Wrap(
              spacing: 10,
              children: filter.categories
                  .map(
                    (cat) => ChoiceChip(
                      label: Text(cat),
                      selected: filter.selectedCategory.value == cat,
                      onSelected: (_) => filter.selectedCategory.value = cat,
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButton<String>(
              value: filter.selectedLocation.value,
              items: filter.locations
                  .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                  .toList(),
              onChanged: (val) {
                if (val != null) filter.selectedLocation.value = val;
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Time Frame',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Column(
              children: filter.timeFrames
                  .map(
                    (tf) => RadioListTile<String>(
                      title: Text(tf),
                      value: tf,
                      groupValue: filter.selectedTimeFrame.value,
                      onChanged: (val) {
                        if (val != null) filter.selectedTimeFrame.value = val;
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Apply'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () => filter.resetFilters(),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
