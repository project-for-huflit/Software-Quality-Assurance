import 'package:flutter/material.dart';

import '../widget/custom_search_bar.dart';
import '../widget/dialog_add_cate.dart';

class BottomSheetCate extends StatefulWidget {
  final Function(String category) onCategorySelected;
  final List<Map<String, dynamic>> categories;
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
    filteredCategories = widget.categories;
  }

  void _filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = widget.categories;
      } else {
        filteredCategories = widget.categories
            .where((category) =>
            category['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogAddCate(
        isIncome: widget.isIncome,
        onCategoryAdded: (newCategory) {
          setState(() {
            widget.categories.add({'name': newCategory, 'icon': Icons.category});
            filteredCategories = List.from(widget.categories);
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
