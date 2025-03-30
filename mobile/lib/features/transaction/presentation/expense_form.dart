import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/apis/categoryExpense/category_expense_api.dart';
import 'package:mobile/apis/categoryExpense/model/category_expense_model.dart';
import 'package:mobile/apis/expense/expense_api.dart';
import 'package:mobile/apis/expense/models/expense_model.dart';
import 'package:mobile/features/transaction/presentation/bottom_sheet_cate.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/features/transaction/widget/recurring_payment.dart';
import '../../../apis/wallets/models/wallet_model.dart';
import '../../../apis/wallets/wallet_api.dart';
import '../../home/presentation/home_screen.dart';
import '../service/gemini_service.dart';
import '../service/ocr_service.dart';
import '../widget/camera_button.dart';
import '../widget/gallery_button.dart';
import '../widget/button_confirm.dart';
import '../widget/text_recognition_service.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, dynamic>? _recognizedText;
  File? _selectedImage;

  Future<void> _handleImageSelected(File? image) async {
    if (image == null) return;
    setState(() {
      _selectedImage = image;
      isLoading = true;
    });

    try {
      List<int> imageBytes = await image.readAsBytes();
      String imageBase64 = base64Encode(imageBytes);

      Map<String, dynamic>? recognizedText = await OCRService.sendImageToOCR("thu",imageBase64);

      await Future.delayed(const Duration(milliseconds: 3000));

      if (recognizedText != null) {
        setState(() {
          _amountController.text = recognizedText['totalAmount']['value'].toString();
          selectedCategory = recognizedText['category'].toString();
          // selectedDate = recognizedText['date'].toString();
          _recognizedText = recognizedText;
        });
        print('Dữ liệu OCR: $_recognizedText');
      }
    } catch (e) {
      print('Lỗi xử lý ảnh: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // @override
  // void dispose() {
  //   TextRecognitionService.dispose();
  //   super.dispose();
  // }

  final TextEditingController _amountController = TextEditingController();
  // final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  late List<String> accountItems = [];

  late List<String> expenseCategories = [];

  String? selectedValue;
  String? selectedCategory;
  String? selectedDate;
  String? selectedAccount;

  Future<void> _fetchCategories() async {
    try {
      List<CategoryExpenseModel> categories = await CateExpenseServices().listCateExpense();
      setState(() {
        expenseCategories = [...categories.map((category) => category.name)];
      });
    } catch (e) {
      print('Lỗi tải danh mục: $e');
    }
  }

  Future<void> _createExpense() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 3000));

    try {
      ExpenseModel newExpense = ExpenseModel(
          amount: _amountController.text,
          category: selectedCategory!,
          expenseAt: DateFormat('yyyy-MM-dd').parse(selectedDate!),
          wallet:  selectedAccount!.split(' (')[0]
      );
      await ExpenseServices().createExpense(newExpense);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tạo chi tiêu thành công!"))
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const HomeScreen(),
          ));


    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e"))
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fecthWallets() async {
    try {
      List<WalletModel> wallets = await WalletServices().listWallet();
      setState(() {
        accountItems = wallets.map((wallet) => "${wallet.name} (${wallet.type})").toList();
      });
    } catch (e) {
      print('Lỗi tải ví: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fecthWallets();
    // _amountController.addListener(() {
    //   final String text = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    //   if (text.isNotEmpty) {
    //     _amountController.value = _amountController.value.copyWith(
    //       text: _currencyFormat.format(int.parse(text)),
    //       selection: TextSelection.collapsed(offset: _currencyFormat.format(int.parse(text)).length),
    //     );
    //   }
    // });
    selectedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      //CameraButton
                      Expanded(
                        child: CameraButton(
                          onImageCaptured: _handleImageSelected,
                        ),
                      ),
                      //GalleryButton
                      Expanded(
                        child: GalleryButton(
                          onImageSelected: _handleImageSelected,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // Amount TextFormField
                  TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số tiền.';
                      }
                      return null;
                    },
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category show modal
                  FormField<String>(
                    validator: (value) {
                      if (selectedCategory == null) {
                        return 'Vui lòng chọn danh mục';
                      }
                      return null;
                    },
                    builder: (FormFieldState<String> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: field.hasError ? Colors.red : Colors.black54, // 🔴 Hiển thị viền đỏ nếu có lỗi
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              title: Text(
                                selectedCategory ?? 'Select Category',
                                style: const TextStyle(fontSize: 16),
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_down),
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  ),
                                  builder: (context) {
                                    return DraggableScrollableSheet(
                                      expand: false,
                                      initialChildSize: 0.8,
                                      minChildSize: 0.4,
                                      maxChildSize: 0.9,
                                      builder: (context, scrollController) {
                                        return BottomSheetCate(
                                          isIncome: false,
                                          categories: expenseCategories,
                                          onCategorySelected: (category) {
                                            setState(() {
                                              selectedCategory = category;
                                              field.didChange(category); // 🔴 Cập nhật trạng thái validator
                                            });
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          if (field.hasError) // 🔴 Hiển thị lỗi bên dưới ListTile nếu có
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 4),
                              child: Text(
                                field.errorText!,
                                style: const TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Date Time Picker
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BoardDateTimePicker(
                      pickerType: DateTimePickerType.datetime,
                      onDateSelected: (DateTime date) {
                        setState(() {
                          selectedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
                        });
                      },
                      customCloseButtonBuilder: (context, isModal, onClose) {
                        return TextButton.icon(
                          onPressed: onClose,
                          icon: const Icon(Icons.check_circle_outline),
                          iconAlignment: IconAlignment.end,
                          label: const Text('Close😉'),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Account Dropdown
                  DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Add more decoration..
                    ),
                    hint: const Text(
                      'Wallet',
                      style: TextStyle(fontSize: 16),
                    ),
                    items: [...accountItems
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
                      const DropdownMenuItem<String>(
                        value: "add_account",
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.blue),
                            SizedBox(width: 8),
                            Text("Thêm tài khoản ví", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Vui lòng chọn ví.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedAccount = value;
                      });
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),

                  // More Detail Button
                  const SizedBox(height: 8),

                  const RecurringPayment(),

                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 16),
                  // Preview Image
                  _selectedImage != null ?
                  Image.file(_selectedImage!) :
                  const SizedBox.shrink(),

                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5), // Làm tối nền
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Đang xử lý...",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ButtonConfirm(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _createExpense();

              }
            },
          ),
        ),
      ),
    );
  }
}
