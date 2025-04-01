import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile/apis/wallets/models/wallet_model.dart';
import 'package:mobile/apis/wallets/wallet_api.dart';
import 'package:mobile/features/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/home/widgets/top_expense.dart';
import 'package:mobile/features/wallet/screens/app.dart';
import 'package:mobile/features/wallet/screens/createWallet/app.dart';
import 'package:mobile/features/wallet/screens/listWallet/app.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';


@GenerateMocks([
  WalletServices,
])
void main() {

  // group('Creation Wallet Form Test', () {
  //   testWidgets('should render all components of the WalletForm',
  //       (WidgetTester tester) async {
  //     await tester.pumpWidget(
  //       const MaterialApp(
  //         home: Scaffold(
  //           body: CreateWalletScreen(),
  //         ),
  //       ),
  //     );
  //   });

  //   expect(find.text('type'), findsOneWidget);
  //   expect(find.text('name'), findsOneWidget);
  //   expect(find.text('amount'), findsOneWidget);
  //   expect(find.byType(DropdownButtonFormField), findsOneWidget);
  //   expect(find.byType(TextFormField), findsOneWidget);
  //   expect(find.byType(TextButton), findsOneWidget);
  // });

  group('Creation Wallet Form Test', () {
    testWidgets('should render all components of the WalletForm',
    (WidgetTester tester) async {
      // Arrange: Build giao diện
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CreateWalletScreen(),
          ),
        ),
      );
  
      await tester.pumpAndSettle();
  
      expect(find.text('Type'), findsOneWidget);
      expect(find.text('Name Wallet'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('List Wallet Test', () {
    testWidgets("should render all components of the list's wallet",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ListWalletScreen(),
          ),
        ),
      );
  
      await tester.pumpAndSettle();
  
      expect(find.text('Wallet'), findsOneWidget);
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(BottomNavBarWidget), findsOneWidget);
      expect(find.byType(TopExpense), findsOneWidget);
    });
  });
}
