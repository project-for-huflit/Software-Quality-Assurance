import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/transaction/presentation/income_form.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:mobile/features/transaction/widget/recurring_payment.dart';

void main() {
  testWidgets('IncomeForm renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IncomeForm(),
      ),
    ));

    // Kiểm tra có ô nhập số tiền không
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);

    

    // Kiểm tra có phần chọn category không
    expect(find.text('Select Category'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);

    // Kiểm tra có DateTime Picker không
    expect(find.byType(BoardDateTimePicker), findsOneWidget);

    // Kiểm tra Dropdown cho tài khoản
    expect(find.byType(DropdownButtonFormField2<String>), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);

    // Kiểm tra có phần recurring payment không
    expect(find.byType(RecurringPayment), findsOneWidget);
  });

  testWidgets('Selecting category updates UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IncomeForm(),
      ),
    ));

    // Mở BottomSheet chọn danh mục
    await tester.tap(find.text('Select Category'));
    await tester.pumpAndSettle();

    // Chọn 'Salary'
    await tester.tap(find.text('Salary'));
    await tester.pumpAndSettle();

    // Kiểm tra UI có cập nhật không
    expect(find.text('Salary'), findsOneWidget);
  });

  testWidgets('Selecting an account updates UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IncomeForm(),
      ),
    ));

    // Mở dropdown chọn tài khoản
    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();

    // Chọn 'Cash'
    await tester.tap(find.text('Cash'));
    await tester.pumpAndSettle();

    // Kiểm tra UI có cập nhật không
    expect(find.text('Cash'), findsOneWidget);
  });

  testWidgets('IncomeForm validates Amount field correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IncomeForm(),
      ),
    ));

    // Nhập số tiền không hợp lệ

    await tester.enterText(find.byType(TextFormField), 'invalid_text');
    await tester.pumpAndSettle();

    // Kiểm tra có thông báo lỗi không
    expect(find.text('Amount must be greater than 0'), findsOneWidget);

    // Nhập số tiền hợp lệ
    await tester.enterText(find.byType(TextFormField), '500');
    await tester.pumpAndSettle();

    // Kiểm tra không còn thông báo lỗi
    expect(find.text('Amount must be greater than 0'), findsNothing);
  });
}
