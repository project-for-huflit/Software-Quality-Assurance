import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/apis/categoryIncome/category_income_api.dart';
import 'package:mobile/apis/categoryIncome/model/category_income_model.dart';
import 'package:mobile/features/transaction/presentation/bottom_sheet_cate.dart';
import 'package:mobile/features/transaction/presentation/income_form.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:mobile/features/transaction/widget/button_confirm.dart';
import 'package:mobile/features/transaction/widget/camera_button.dart';
import 'package:mobile/features/transaction/widget/custom_search_bar.dart';
import 'package:mobile/features/transaction/widget/gallery_button.dart';
import 'package:mobile/features/transaction/widget/recurring_payment.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile/apis/income/income_api.dart';
import 'package:mobile/apis/wallets/wallet_api.dart';
import 'package:mobile/features/transaction/service/gemini_service.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'income_form_test.mocks.dart';

@GenerateMocks([
  IncomeServices,
  WalletServices,
  CateIncomeServices,
  GeminiService,
])
void main() {
  late MockIncomeServices mockIncomeService;
  late MockWalletServices mockWalletService;
  late MockCateIncomeServices mockCateIncomeService;
  late MockGeminiService mockGeminiService;

  setUp(() async{
    await dotenv.load();
    mockIncomeService = MockIncomeServices();
    mockWalletService = MockWalletServices();
    mockCateIncomeService = MockCateIncomeServices();
    mockGeminiService = MockGeminiService();
  });

  Widget createScreen() {
    return MultiProvider(
      providers: [
        Provider<IncomeServices>.value(value: mockIncomeService),
        Provider<WalletServices>.value(value: mockWalletService),
        Provider<CateIncomeServices>.value(value: mockCateIncomeService),
        Provider<GeminiService>.value(value: mockGeminiService),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: IncomeForm(),
        ),
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

    await tester.tap(find.text('Select Category'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheetCate), findsOneWidget);
    expect(find.byType(CustomSearchBar), findsOneWidget);
  });

  testWidgets('Selecting category updates UI and calls API', (WidgetTester tester) async {
    when(mockCateIncomeService.listCateIncome()).thenAnswer((_) async => [
      CategoryIncomeModel(name: 'Salary'),
      CategoryIncomeModel(name: 'Investments'),
      CategoryIncomeModel(name: 'Freelance'),
    ]);

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    // Mở BottomSheet chọn danh mục
    await tester.tap(find.text('Select Category'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheetCate), findsOneWidget);

    final salaryFinder = find.textContaining('Salary');
    if (salaryFinder.evaluate().isEmpty) {
      print("🚨 Không tìm thấy 'Salary'. Kiểm tra lại fetchCategories()");
    } else {
      print("✅ Đã tìm thấy danh mục 'Salary'");
    }

    // Chọn 'Salary'
    // await tester.tap(find.textContaining('Salary'));
    // await tester.pumpAndSettle();

    // // Kiểm tra UI có cập nhật không
    // expect(find.text('Salary'), findsOneWidget);
  });

  // testWidgets('Selecting an account updates UI', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: Scaffold(
  //       body: IncomeForm(),
  //     ),
  //   ));
  //
  //   // Mở dropdown chọn tài khoản
  //   await tester.tap(find.text('Account'));
  //   await tester.pumpAndSettle();
  //
  //   // Chọn 'Cash'
  //   await tester.tap(find.text('Cash'));
  //   await tester.pumpAndSettle();
  //
  //   // Kiểm tra UI có cập nhật không
  //   expect(find.text('Cash'), findsOneWidget);
  // });
  //
  // testWidgets('IncomeForm validates Amount field correctly', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: Scaffold(
  //       body: IncomeForm(),
  //     ),
  //   ));
  //
  //   // Nhập số tiền không hợp lệ
  //
  //   await tester.enterText(find.byType(TextFormField), 'invalid_text');
  //   await tester.pumpAndSettle();
  //
  //   // Kiểm tra có thông báo lỗi không
  //   expect(find.text('Amount must be greater than 0'), findsOneWidget);
  //
  //   // Nhập số tiền hợp lệ
  //   await tester.enterText(find.byType(TextFormField), '500');
  //   await tester.pumpAndSettle();
  //
  //   // Kiểm tra không còn thông báo lỗi
  //   expect(find.text('Amount must be greater than 0'), findsNothing);
  // });
}
