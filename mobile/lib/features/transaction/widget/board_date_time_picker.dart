import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';

class BoardDateTimePicker extends StatelessWidget {
  BoardDateTimePicker({
    super.key,
    required this.pickerType,
    this.customCloseButtonBuilder,
    this.onDateSelected, // Thêm callback khi chọn ngày
  });

  final DateTimePickerType pickerType;
  final Function(DateTime)? onDateSelected; // Callback khi chọn ngày
  final Widget Function(
      BuildContext context,
      bool isModal,
      void Function() onClose,
      )? customCloseButtonBuilder;

  final ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final controller = BoardDateTimeController();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showBoardDateTimePicker(
            context: context,
            pickerType: pickerType,
            options: BoardDateTimeOptions(
              languages: const BoardPickerLanguages.en(),
              startDayOfWeek: DateTime.sunday,
              pickerFormat: PickerFormat.ymd,
              withSecond: DateTimePickerType.time == pickerType,
              customOptions: DateTimePickerType.time == pickerType
                  ? BoardPickerCustomOptions(
                seconds: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55],
              )
                  : null,
            ),
            valueNotifier: date,
            controller: controller,
            customCloseButtonBuilder: customCloseButtonBuilder,
          );
          if (result != null) {
            date.value = result;
            onDateSelected!(result); // Gọi callback để cập nhật `selectedDate`
            print('result: $result');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
          child: Row(
            children: [
              const SizedBox(width: 12),
              ValueListenableBuilder(
                valueListenable: date,
                builder: (context, data, _) {
                  return Text(
                    BoardDateFormat(pickerType.formatter(
                      withSecond: DateTimePickerType.time == pickerType,
                    )).format(data),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


extension DateTimePickerTypeExtension on DateTimePickerType {
  String get title {
    switch (this) {
      case DateTimePickerType.date:
        return 'Date';
      case DateTimePickerType.datetime:
        return 'DateTime';
      case DateTimePickerType.time:
        return 'Time';
    }
  }

  IconData get icon {
    switch (this) {
      case DateTimePickerType.date:
        return Icons.date_range_rounded;
      case DateTimePickerType.datetime:
        return Icons.date_range_rounded;
      case DateTimePickerType.time:
        return Icons.schedule_rounded;
    }
  }

  Color get color {
    switch (this) {
      case DateTimePickerType.date:
        return Colors.blue;
      case DateTimePickerType.datetime:
        return Colors.orange;
      case DateTimePickerType.time:
        return Colors.pink;
    }
  }

  String get format {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        return 'HH:mm';
    }
  }

  String formatter({bool withSecond = false}) {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        // return withSecond ? 'HH:mm:ss' : 'HH:mm';
        return 'HH:mm';
    }
  }
}
