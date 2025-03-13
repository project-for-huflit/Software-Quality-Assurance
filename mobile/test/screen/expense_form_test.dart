import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/transaction/presentation/expense_form.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';

void main() {
  group('ExpenseForm Widget Test', () {
    testWidgets('should render all components of the ExpenseForm', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpenseForm(),
          ),
        ),
      );

      // Assert
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Select Category'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget); // Input for amount
      expect(find.byType(DropdownButtonFormField2), findsOneWidget); // Dropdown for account
      expect(find.byType(BoardDateTimePicker), findsOneWidget); // Date picker
      expect(find.byType(TextButton), findsOneWidget); // More Detail button
    });

    testWidgets('should allow entering an amount', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpenseForm(),
          ),
        ),
      );

      // Act
      final amountField = find.byType(TextFormField);
      await tester.enterText(amountField, '500');

      // Assert
      expect(find.text('500'), findsOneWidget);
    });

    testWidgets('should open category bottom sheet when tapping on "Select Category"', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpenseForm(),
          ),
        ),
      );

      // Act
      final categoryTile = find.text('Select Category');
      await tester.tap(categoryTile);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Gym'), findsOneWidget); // Assuming 'Gym' is in the category list
    });

    testWidgets('should allow selecting an account from the dropdown', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpenseForm(),
          ),
        ),
      );

      // Act
      final dropdown = find.byType(DropdownButtonFormField2);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final accountItem = find.text('Cash').last;
      await tester.tap(accountItem);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Cash'), findsOneWidget);
    });

    testWidgets('should allow selecting a date using the BoardDateTimePicker', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpenseForm(),
          ),
        ),
      );

      // Act
      final datePicker = find.byType(BoardDateTimePicker);
      await tester.tap(datePicker);
      await tester.pumpAndSettle();

      // This is where you would add more detailed interactions depending on BoardDateTimePicker's behavior.
    });
  });
}
