import 'package:flutter/material.dart';
import '../../../../core/constants/news_categories.dart';
import '../../../../core/theme/app_colors.dart';

class CategoryChips extends StatelessWidget {
  final NewsCategory? selectedCategory;
  final ValueChanged<NewsCategory?> onCategorySelected;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  Color _getCategoryColor(NewsCategory category) {
    switch (category) {
      case NewsCategory.general:
        return AppColors.categoryGeneral;
      case NewsCategory.business:
        return AppColors.categoryBusiness;
      case NewsCategory.technology:
        return AppColors.categoryTechnology;
      case NewsCategory.sports:
        return AppColors.categorySports;
      case NewsCategory.entertainment:
        return AppColors.categoryEntertainment;
      case NewsCategory.health:
        return AppColors.categoryHealth;
      case NewsCategory.science:
        return AppColors.categoryScience;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // All category
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('All'),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: selectedCategory == null ? Colors.white : null,
              ),
            ),
          ),
          // Category chips
          ...NewsCategory.values.map((category) {
            final isSelected = selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category.displayName),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(category),
                selectedColor: _getCategoryColor(category),
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : null,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
