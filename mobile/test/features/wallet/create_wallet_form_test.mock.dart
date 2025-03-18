
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart';
import 'dart:async' as _i3;
import 'package:mobile/apis/wallets/models/wallet_model.dart' as _i6;
import 'package:mobile/apis/wallets/wallet_api.dart' as _i5;

class MockWalletService 
extends Mock 
implements _i5.WalletServices {
  MockWalletServices() {
    throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i6.WalletModel>> listWallet() =>
      (super.noSuchMethod(
            Invocation.method(#listWallet, []),
            returnValue: _i3.Future<List<_i6.WalletModel>>.value(
              <_i6.WalletModel>[],
            ),
          )
          as _i3.Future<List<_i6.WalletModel>>);

  @override
  _i3.Future<_i6.WalletModel?> createWallet(_i6.WalletModel? wallet) =>
      (super.noSuchMethod(
            Invocation.method(#createWallet, [wallet]),
            returnValue: _i3.Future<_i6.WalletModel?>.value(),
          )
          as _i3.Future<_i6.WalletModel?>);
}
