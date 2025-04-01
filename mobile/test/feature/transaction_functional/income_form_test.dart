import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/transaction/widget/board_date_time_picker.dart';
import 'package:mobile/features/transaction/widget/button_confirm.dart';
import 'package:mobile/features/transaction/widget/camera_button.dart';
import 'package:mobile/features/transaction/widget/gallery_button.dart';
import 'package:mobile/features/transaction/widget/recurring_payment.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mobile/apis/income/income_api.dart';
import 'package:mobile/apis/income/models/income_model.dart';
import 'package:mobile/apis/categoryIncome/category_income_api.dart';
import 'package:mobile/apis/categoryIncome/model/category_income_model.dart';
import 'package:mobile/apis/wallets/models/wallet_model.dart';
import 'package:mobile/apis/wallets/wallet_api.dart';
import 'package:mobile/features/transaction/service/gemini_service.dart';
import 'package:mobile/features/transaction/presentation/income_form.dart';
import 'package:mobile/features/transaction/presentation/bottom_sheet_cate.dart';
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

  setUp(() {
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
  });

  testWidgets('Selecting category updates UI and calls API', (WidgetTester tester) async {
    // Mock API trả về danh mục
    when(mockCateIncomeService.listCateIncome()).thenAnswer((_) async => [
      CategoryIncomeModel(name: 'Salary'),
      CategoryIncomeModel(name: 'Freelance'),
    ]);

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    // Mở BottomSheet chọn danh mục
    await tester.tap(find.text('Select Category'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheetCate), findsOneWidget);
    expect(find.text('Salary'), findsOneWidget);
    expect(find.text('Freelance'), findsOneWidget);

    // Chọn 'Salary'
    await tester.tap(find.text('Salary'));
    await tester.pumpAndSettle();

    // Kiểm tra UI có cập nhật không
    expect(find.text('Salary'), findsOneWidget);
  });

  testWidgets('Loading wallets correctly', (WidgetTester tester) async {
    // Mock API trả về danh sách ví
    when(mockWalletService.listWallet()).thenAnswer((_) async => [
      WalletModel( name: 'Main Wallet', type: 'Main Wallet', amount: 0),
      WalletModel( name: 'Savings', type: 'Savings', amount: 0),
    ]);

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    // Kiểm tra dropdown hiển thị đúng
    expect(find.text('Account'), findsOneWidget);

    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();

    expect(find.text('Main Wallet'), findsOneWidget);
    expect(find.text('Savings'), findsOneWidget);
  });

  testWidgets('Submitting an income form successfully', (WidgetTester tester) async {
    // Mock API danh mục & ví
    when(mockCateIncomeService.listCateIncome()).thenAnswer((_) async => [
      CategoryIncomeModel( name: 'Salary'),
    ]);
    when(mockWalletService.listWallet()).thenAnswer((_) async => [
      WalletModel( name: 'Savings', type: 'Savings', amount: 0),
    ]);

    // Mock API tạo thu nhập
    when(mockIncomeService.createIncome(any)).thenAnswer((_) async => IncomeModel(
      amount: '5000',
      category: 'Salary',
      incomeAt: DateTime.now(),
      wallet: 'Main Wallet',
    ));

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    // Nhập số tiền
    await tester.enterText(find.byType(TextFormField), '5000');
    await tester.pumpAndSettle();

    // Chọn danh mục
    await tester.tap(find.text('Select Category'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salary'));
    await tester.pumpAndSettle();

    // Chọn ví
    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Main Wallet'));
    await tester.pumpAndSettle();

    // Nhấn nút xác nhận
    await tester.tap(find.byType(ButtonConfirm));
    await tester.pumpAndSettle();

    // Kiểm tra API được gọi
    verify(mockIncomeService.createIncome(any)).called(1);
  });
}
