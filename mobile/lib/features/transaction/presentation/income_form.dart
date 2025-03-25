import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/apis/income/income_api.dart';
import 'package:mobile/apis/income/models/income_model.dart';
import 'package:mobile/features/transaction/presentation/bottom_sheet_cate.dart';
import 'package:mobile/features/transaction/service/gemini_service.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/features/transaction/widget/camera_button.dart';
import 'package:mobile/features/transaction/widget/recurring_payment.dart';
import 'package:provider/provider.dart';
import '../../../apis/categoryIncome/category_income_api.dart';
import '../../../apis/categoryIncome/model/category_income_model.dart';
import '../../../apis/wallets/models/wallet_model.dart';
import '../../../apis/wallets/wallet_api.dart';
import '../widget/button_confirm.dart';
import '../widget/gallery_button.dart';
import '../widget/text_recognition_service.dart';

class IncomeForm extends StatefulWidget {
  const IncomeForm({super.key});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? _selectedImage;
  String _recognizedText = '';
  final GeminiService _geminiService = GeminiService();

  Future<void> _handleImageSelected(File? image) async {
    if (image == null) return;
    setState(() => _selectedImage = image);

    final text = await TextRecognitionService.recognizeText(image);
    setState(() => _recognizedText = text);
    print('Dữ liệu OCR: $_recognizedText');
    try {
      await _geminiService.processText(_recognizedText, 'tiền chi');
    } catch (e) {
      print('Lỗi xử lý Gemini: $e');
    }
  }

  @override
  void dispose() {
    TextRecognitionService.dispose();
    super.dispose();
  }

  final TextEditingController _amountController = TextEditingController();
  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  late List<String> accountItems = [];

  late List<String> incomeCategories = [];

  String? selectedValue;
  String? selectedCategory;
  String? selectedDate;
  String? selectedAccount;

  Future<void> _fetchCategories() async {
    // final cateIncomeService = Provider.of<CateIncomeServices>(context, listen: false);
    try {
      List<CategoryIncomeModel> categories = await CateIncomeServices().listCateIncome();
      setState(() {
        incomeCategories = categories.map((category) => category.name).toList();
      });
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi tải danh mục: $e');
    }
  }

  Future<void> _createIncome() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 3000));

    try {
      IncomeModel newIncome = IncomeModel(
          amount: _amountController.text,
          category: selectedCategory!,
          incomeAt: DateFormat('yyyy-MM-dd').parse(selectedDate!),
          wallet: selectedAccount!
      );
       await IncomeServices().createIncome(newIncome);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tạo thu nhập thành công!"))
      );

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
        accountItems = wallets.map((wallet) => wallet.name).toList();
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

                    // Category showmodal
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
                                            isIncome: true,
                                            categories: incomeCategories,
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

                    // DateTime Picker
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
                        'Account',
                        style: TextStyle(fontSize: 16),
                      ),
                      items:  [...accountItems
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
                _createIncome();
              }
            },
          ),
        ),
      ),
    );
  }
}
