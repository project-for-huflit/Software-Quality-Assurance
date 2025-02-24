import 'package:flutter/material.dart';

import '../widget/custom_search_bar.dart';

class BottomSheetCate extends StatefulWidget {
  final Function(String category) onCategorySelected;
  final List<Map<String, dynamic>> categories;

  const BottomSheetCate({
    super.key,
    required this.onCategorySelected,
    required this.categories,
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
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
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
