import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:mobile/features/transaction/widget/button_confirm.dart';
import 'package:mobile/features/transaction/widget/camera_button.dart';
import 'package:mobile/features/transaction/widget/gallery_button.dart';
import 'package:mobile/features/transaction/widget/recurring_payment.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:mobile/apis/income/income_api.dart';
// import 'package:mobile/apis/income/models/income_model.dart';
// import 'package:mobile/apis/categoryIncome/category_income_api.dart';
// import 'package:mobile/apis/categoryIncome/model/category_income_model.dart';
// import 'package:mobile/apis/wallets/models/wallet_model.dart';
// import 'package:mobile/apis/wallets/wallet_api.dart';
// import 'package:mobile/features/transaction/service/gemini_service.dart';
import 'package:mobile/features/transaction/presentation/income_form.dart';
// import 'package:mobile/features/transaction/presentation/bottom_sheet_cate.dart';
// import 'income_form_test.mocks.dart';

void main() {
  Widget createScreen() {
    return  const MaterialApp(
        home: Scaffold(
          body: IncomeForm(),
        ),
      );
  }

  testWidgets('IncomeForm renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    expect(find.byType(CameraButton), findsOneWidget);
    expect(find.byType(GalleryButton), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(FormField<String>), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('Select Category'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    expect(find.byType(BoardDateTimePicker), findsOneWidget);
    expect(find.byType(DropdownButtonFormField2<String>), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.byType(RecurringPayment), findsOneWidget);
    expect(find.byType(ButtonConfirm), findsOneWidget);
  });

  
}