import 'package:flutter/material.dart';

import '../widget/custom_search_bar.dart';
import '../widget/dialog_add_cate.dart';

class BottomSheetCate extends StatefulWidget {
  final Function(String category) onCategorySelected;
  final List<String> categories;
  final bool isIncome;

  const BottomSheetCate({
    super.key,
    required this.onCategorySelected,
    required this.categories,
    required this.isIncome,
  });

  @override
  State<BottomSheetCate> createState() => _BottomSheetCateState();
}

class _BottomSheetCateState extends State<BottomSheetCate> {
  final TextEditingController _searchController = TextEditingController();

  late List<Map<String, dynamic>> filteredCategories;

  @override
  void initState() {
    super.initState();
    filteredCategories = widget.categories.map((categoryName) {
      return {
        'name': categoryName,
        'icon': getCategoryIcon(categoryName),
      };
    }).toList();
  }

  void _filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = widget.categories.map((categoryName) {
          return {
            'name': categoryName,
            'icon': getCategoryIcon(categoryName),
          };
        }).toList();
      } else {
        filteredCategories = widget.categories
            .where((categoryName) =>
            categoryName.toLowerCase().contains(query.toLowerCase()))
            .map((categoryName) => {
          'name': categoryName,
          'icon': getCategoryIcon(categoryName),
        })
            .toList();
      }
    });
  }

  IconData getCategoryIcon(String? categoryName) {
    if (categoryName == null) return Icons.category;
    switch (categoryName.toLowerCase()) {
      case 'salary':
        return Icons.attach_money;
      case 'home':
        return Icons.home;
      case 'food':
        return Icons.fastfood;
      case 'shopping':
        return Icons.shopping_cart;
      case 'travel':
        return Icons.flight;
      case 'entertainment':
        return Icons.movie;
      case 'car':
        return Icons.directions_car;
      case 'health':
        return Icons.local_hospital;
      case 'gift':
        return Icons.card_giftcard;
      default:
        return Icons.category;
    }
  }


  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogAddCate(
        isIncome: widget.isIncome,
        onCategoryAdded: (newCategory) {
          setState(() {
            widget.categories.add(newCategory);
            filteredCategories.add(<String, Object>{
              'name': newCategory,
              'icon': getCategoryIcon(newCategory) as Object,
            });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          CustomSearchBar(
            controller: _searchController,
            onChanged: _filterCategories,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: filteredCategories.length + 1,
              itemBuilder: (context, index) {
                if (index == filteredCategories.length) {
                  return GestureDetector(
                    onTap: () => _showAddCategoryDialog(context),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(Icons.add, color: Colors.black, size: 24),
                        ),
                        const SizedBox(height: 8),
                        const Text("Thêm", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                }
                final category = filteredCategories[index];
                return GestureDetector(
                  onTap: () {
                    widget.onCategorySelected(category['name']);
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(
                          category['icon'],
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}