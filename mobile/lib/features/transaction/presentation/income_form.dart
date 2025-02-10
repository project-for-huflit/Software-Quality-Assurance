import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/transaction/presentation/bottom_sheet_cate.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';

class IncomeForm extends StatefulWidget {
  const IncomeForm({super.key});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {

  final List<String> accountItems = [
    'Cash', 'Bank', 'Credit Card', 'Create Account'
  ];

  final List<Map<String, dynamic>> incomeCategories = [
    {'name': 'Salary', 'icon': Icons.account_balance_wallet},
    {'name': 'Investment', 'icon': Icons.trending_up},
    {'name': 'Referral', 'icon': Icons.person},
  ];

  String? selectedValue;
  String? selectedCategory;
  String? selectedDate;
  String? selectedAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Category showmodal
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
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
                        expand: false, // Cho phép chiều cao giới hạn theo thiết kế
                        initialChildSize: 0.8, // 60% chiều cao ban đầu
                        minChildSize: 0.4, // 40% chiều cao tối thiểu
                        maxChildSize: 0.9, // 90% chiều cao tối đa
                        builder: (context, scrollController) {
                          return BottomSheetCate(
                            categories: incomeCategories,
                            onCategorySelected: (category) {
                              setState(() {
                                selectedCategory = category;
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

            const SizedBox(height: 16),

            // DateTime Picker
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(16),
              ),
              child: BoardDateTimePicker(
                pickerType: DateTimePickerType.datetime,
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
              items: accountItems
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Row(
                  children: [
                    Icon(
                      item == 'Cash'
                          ? Icons.money
                          : item == 'Bank'
                          ? Icons.account_balance
                          : item == 'Credit Card'
                          ? Icons.credit_card
                          : Icons.add,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select account.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when selected item is changed.
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
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 24),
            // More Detail Button
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // Thực hiện khi nhấn nút
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                label: const Text('More detail'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
    );
  }
}
