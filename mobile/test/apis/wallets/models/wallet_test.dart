import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/apis/wallets/models/wallet.dart';

void main() {
  // ignore: unused_local_variable
  late Wallet wallet;
  String descriptionWallet = 'Wallet';
  String descriptionWalletFromJson = 'WalletFromJson';
  String descriptionWalletToJson = 'WalletToJson';

  bodySetUpAll() {
    wallet = Wallet(
      id: '',
      nameWallet: '',
      typeWallet: '',
      currency: '',
      amount: 0,
    );
  }

  setUpAll(bodySetUpAll);

  bodyDescriptionWallet() {
    group('emptyWallet', () {
      test(
        'should return an empty Wallet object',
        () {
          // ARRANGE
          var expected = Wallet(
            id: '',
            nameWallet: '',
            typeWallet: '',
            currency: '',
            amount: 0,
          );
          // ACT
          const wallet = Wallet.empty();
          // ASSERT
          expect(wallet, equals(expected));
        },
      );
    });
  }

  group(descriptionWallet, bodyDescriptionWallet);

  bodyDescriptionWalletFromJson() {
    test(
      'should return a valid Wallet object',
      () {
        // ARRANGE
        const json = {
          'street': 'Kulas Light',
          'suite': 'Apt. 556',
          'city': 'Gwenborough',
          'zipcode': '92998-3874',
          'geo': {
            'lat': '-37.3159',
            'lng': '81.1496',
          },
        };
        // ACT
        final newWallet = Wallet.fromJson(json);
        // ASSERT
        expect(newWallet, isA<Wallet>());
        expect(newWallet, equals(wallet));
      },
    );
  }

  group(descriptionWalletFromJson, bodyDescriptionWalletFromJson);

  bodyDescriptionWalletToJson() {
    test(
      'should return a valid Map',
      () {
        // ARRANGE
        final expected = {
          'street': 'Kulas Light',
          'suite': 'Apt. 556',
          'city': 'Gwenborough',
          'zipcode': '92998-3874',
          'geo': {
            'lat': '-37.3159',
            'lng': '81.1496',
          },
        };
        // ACT
        final json = wallet.toJson();
        // ASSERT
        expect(json, isA<Map>());
        expect(json, equals(expected));
      },
    );
  }

  group(descriptionWalletToJson, bodyDescriptionWalletToJson);
}