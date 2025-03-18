import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/apis/categoryIncome/category_income_api.dart';
import 'package:mobile/apis/categoryIncome/model/category_income_model.dart';

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

  // Future<void> _saveCategory() async {
  //   String name = _controller.text.trim();
  //   print("Name: $name");
  //   if (name.isEmpty) return;
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   String baseUrl = dotenv.env['API_URL'] ?? "https://fallback-api.com/api";;
  //   String apiUrl = widget.isIncome
  //       ? "$baseUrl/cate-income"
  //       : "$baseUrl/cate-expense";
  //
  //   print("API URL: $apiUrl");
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"name": name}),
  //     );
  //
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       widget.onCategoryAdded(name);
  //       Navigator.pop(context);
  //     } else {
  //       _showError("Lỗi khi thêm danh mục!");
  //     }
  //   } catch (e) {
  //     print("Error2: $e");
  //     _showError("Lỗi kết nối server!");
  //   }
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Future<void> _saveCategory() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 3000));

    try {
      CategoryIncomeModel newCateIncome = CategoryIncomeModel(
        name: _controller.text.trim(),
      );

      await CateIncomeServices().createCateIncome(newCateIncome);

      if (mounted) {
        widget.onCategoryAdded(_controller.text.trim());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e"))
      );
    }
    finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
      widget.onCategoryAdded(_controller.text.trim());
    }
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
