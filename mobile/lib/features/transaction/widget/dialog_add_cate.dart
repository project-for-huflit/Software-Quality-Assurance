import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DialogAddCate extends StatefulWidget {
  final Function(String) onCategoryAdded;
  final bool isIncome;

  const DialogAddCate({
    super.key,
    required this.onCategoryAdded,
    required this.isIncome,
  });

  @override
  State<DialogAddCate> createState() => _DialogAddCateState();
}

class _DialogAddCateState extends State<DialogAddCate> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveCategory() async {
    String name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    String baseUrl = dotenv.env['API_URL'] ?? "https://fallback-api.com/api";;
    String apiUrl = widget.isIncome
        ? "$baseUrl/cate_income"
        : "$baseUrl/cate_expense";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        widget.onCategoryAdded(name);
        Navigator.pop(context);
      } else {
        _showError("Lỗi khi thêm danh mục!");
      }
    } catch (e) {
      _showError("Lỗi kết nối server!");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Thêm danh mục"),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Nhập tên danh mục"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hủy"),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveCategory,
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Lưu"),
        ),
      ],
    );
  }
}
