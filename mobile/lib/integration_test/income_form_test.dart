import 'package:flutter/cupertino.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/transaction/presentation/income_form.dart' as app;

void main() {


  group("Income Form Test", ()
  {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Full App Test", (tester) async{
      app.IncomeForm();
      tester.pumpAndSettle();

      final amountFormFiled = find.byKey(Key("amountIncome"));
      final categoryIncome = find.byKey(Key("categoryIncome"));

    });
  });
}