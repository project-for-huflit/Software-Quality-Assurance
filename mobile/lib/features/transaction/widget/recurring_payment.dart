import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'board_date_time_picker.dart';

class RecurringPayment extends StatefulWidget {
  const RecurringPayment({super.key});

  @override
  State<RecurringPayment> createState() => _RecurringPaymentState();
}

class _RecurringPaymentState extends State<RecurringPayment> {
  final List<String> _recurringTime = [
    'By Day', 'By Week', 'By Month', 'Quarterly', 'Yearly'
  ];

  final List<String> _numberOfTimes = [
    'Never', 'Once', 'Twice', 'Third', 'Fourth', 'Fifth'
  ];

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _recurringTime.map((item) {
              return ListTile(
                title: Text(item, style: const TextStyle(fontSize: 16)),
                onTap: () {
                  setState(() {
                    selectedValue = item;
                  });
                  Navigator.pop(context); // Đóng BottomSheet sau khi chọn
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  bool _isExpanded = false;
  bool _isRecurring = false;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        trailing: const SizedBox.shrink(),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isExpanded ? "Hidden" : "More details",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          const Divider(
            thickness: 0.5,
            color: Colors.black,
          ),
          SwitchListTile(
            title: const Text('Recurring Payment',style: TextStyle(fontSize: 14),),
            value: _isRecurring,
            onChanged: (bool value) {
              setState(() {
                _isRecurring = value;
              });
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              children: [
                if (_isRecurring)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: BoardDateTimePicker(
                            pickerType: DateTimePickerType.time,
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

                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          value: _numberOfTimes.first,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            isDense: true,
                            // Add more decoration..
                          ),
                          hint: const Text(
                            'Recurring Time',
                            style: TextStyle(fontSize: 16),
                          ),
                          items: _numberOfTimes
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Row(
                              children: [
                                Text(
                                  item,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ))
                              .toList(),
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
                              color: Colors.white,
                            ),
                            maxHeight: 200,
                            direction: DropdownDirection.textDirection,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),

                        const SizedBox(height: 16),

                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            isDense: true,
                            // Add more decoration..
                          ),
                          hint: const Text(
                            'Recurring Time',
                            style: TextStyle(fontSize: 16),
                          ),
                          items: _recurringTime
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Row(
                              children: [
                                Text(
                                  item,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ))
                              .toList(),
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
                              color: Colors.white,
                            ),
                            maxHeight: 200,
                            direction: DropdownDirection.textDirection,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (_isRecurring) const SizedBox(height: 16),
              ],
            ),
          ),
          TextFormField(
            controller: TextEditingController(),
            decoration: InputDecoration(
              labelText: 'Event',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: TextEditingController(),
            decoration: InputDecoration(
              labelText: 'Payee',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}


