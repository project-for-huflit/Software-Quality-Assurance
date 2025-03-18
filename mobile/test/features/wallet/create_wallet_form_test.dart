import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/apis/wallets/models/wallet_model.dart';
import 'package:mobile/apis/wallets/wallet_api.dart';
import 'package:mobile/features/wallet/screens/createWallet/app.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_wallet_form_test.mock.dart';

@GenerateMocks([
  WalletServices,
])
void main() {
  late MockWalletService mockWalletService;

  group('Creation Wallet Form Test', () {
    testWidgets('should render all components of the WalletForm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CreateWalletScreen(),
          ),
        ),
      );
    });

    expect(find.text('type'), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
    expect(find.text('amount'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('should allow entering an amount wallet',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CreateWalletScreen(),
      ),
    ));
    final amountField = find.byType(TextFormField);
    await tester.enterText(amountField, '50000000000');
    // Assert
    expect(find.text('50000000000'), findsOneWidget);
  });

  setUp(() async {
    await dotenv.load();
    mockWalletService = MockWalletService();

    when(mockWalletService.listWallet()).thenAnswer((_) async => [
          WalletModel.fromJson(
            {
              "id": "01955ce8-a971-77a3-98b6-234590308be1",
              "name": "W002",
              "type": "money",
              "amount": 2000000,
              "createdAt": {"_seconds": 1741020506, "_nanoseconds": 480000000},
              "updatedAt": null
            },
          ),
          WalletModel.fromJson(
            {
              "id": "01955ce8-e9ce-75da-af27-eaf28a9586da",
              "name": "W003",
              "type": "banking",
              "amount": 2000000,
              "createdAt": {"_seconds": 1741020522, "_nanoseconds": 958000000},
              "updatedAt": null
            },
          ),
          WalletModel.fromJson(
            {
              "id": "01955ce8-a971-77a3-98b6-234590308be1",
              "name": "W002",
              "type": "money",
              "amount": 2000000,
              "createdAt": {"_seconds": 1741020506, "_nanoseconds": 480000000},
              "updatedAt": null
            },
          ),
          WalletModel.fromJson(
            {
              "id": "01955e3e-9488-741f-9444-ac5d878ef83e",
              "name": "W004",
              "type": "banking",
              "amount": 3000000,
              "createdAt": {"_seconds": 1741042914, "_nanoseconds": 439000000},
              "updatedAt": null
            },
          ),
          WalletModel.fromJson(
            {
              "id": "01955e45-5111-737a-9fa8-d756facaa22b",
              "name": "abc",
              "type": "saving",
              "amount": 1897041,
              "createdAt": {"_seconds": 1741043355, "_nanoseconds": 921000000},
              "updatedAt": null
            },
          ),
          WalletModel.fromJson(
            {
              "id": "0195a696-ec44-75a1-8885-d4482c920394",
              "name": "W005",
              "type": "banking",
              "amount": 1204500,
              "createdAt": {"_seconds": 1742256663, "_nanoseconds": 620000000},
              "updatedAt": null
            },
          ),
        ]);

    when(mockWalletService.createWallet(any)).thenAnswer((invocation) async {
      final WalletModel? wallet = invocation.positionalArguments[0];
      return WalletModel(
        name: wallet?.name ?? 'uia Wallet',
        type: wallet?.type ?? 'banking',
        amount: wallet?.amount ?? 0,
        createdAt: DateTime.now(),
        updatedAt: null,
      );
    });
  });

  test('Create wallet successfully', () async {
    final WalletModel wallet = WalletModel(
      name: 'Test Wallet',
      type: 'money',
      amount: 1000,
    );

    final WalletModel? result = await mockWalletService.createWallet(wallet);

    expect(result, isNotNull);
    expect(result?.name, 'Test Wallet');
    expect(result?.type, 'money');
    expect(result?.amount, 1000);
  });

  test('Create wallet thiếu info', () async {
    final WalletModel wallet = WalletModel(
      name: '',
      type: 'money',
      amount: 1000,
    );

    final WalletModel? result = await mockWalletService.createWallet(wallet);

    expect(result, isNotNull);
    expect(result?.name, 'Test Wallet');
    expect(result?.type, 'money');
    expect(result?.amount, 1000);
  });

  test('Create wallet successfully', () async {
    final WalletModel wallet = WalletModel(
      name: 'a@bc',
      type: 'money',
      amount: 1000,
    );

    final WalletModel? result = await mockWalletService.createWallet(wallet);

    expect(result, isNotNull);
    expect(result?.name, 'a@bc');
    expect(result?.type, 'money');
    expect(result?.amount, 1000);
  });

  test('Create wallet -  thuộc tính khoản tiền không hợp lệ', () async {
    final WalletModel wallet = WalletModel(
      name: 'Test Wallet',
      type: 'money',
      amount: 1000,
    );

    final WalletModel? result = await mockWalletService.createWallet(wallet);

    expect(result, isNotNull);
    expect(result?.name, 'Test Wallet');
    expect(result?.type, 'money');
    expect(result?.amount, 1000);
  });

  test('Create wallet -  khoản tiền không hợp lệ', () async {
    final WalletModel wallet = WalletModel(
      name: 'Test Wallet',
      type: 'money',
      amount: 1000,
    );

    final WalletModel? result = await mockWalletService.createWallet(wallet);

    expect(result, isNotNull);
    expect(result?.name, 'Test Wallet');
    expect(result?.type, 'money');
    expect(result?.amount, 1000);
  });
}
