import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/apis/wallets/constants/wallet_url.dart';

import 'package:mobile/apis/wallets/models/wallet_model.dart';

class WalletServices{
  Future<List<WalletModel>> listWallet() {
    return http
        .get(walletUrls.API_WALLET_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
 
      if(statusCode != 200){
        // ignore: avoid_print
        // print(response.reasonPhrase);
        throw Exception("Error load api");
      }
 
      const JsonDecoder decoder = JsonDecoder();

      final List<dynamic> walletList = decoder.convert(jsonBody); 
      // ignore: avoid_print
      // print(walletList);
      return walletList.map((walletRaw) => WalletModel.fromJson(walletRaw)).toList();
    });
  }

  Future<WalletModel?> createWallet(WalletModel wallet) async {
    return await http
      .post(
        walletUrls.API_CREATE_WALLET,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(wallet.toJson()),
      )
      .then((http.Response response) {
        final String jsonBody = response.body;
        final int statusCode = response.statusCode;

        if(statusCode != 200){
          // ignore: avoid_print
          print("⚠️ Error: $statusCode - $jsonBody");
          throw Exception("Error load api");
        }

        const JsonDecoder decoder = JsonDecoder();

        final dynamic responseCreateWallet = decoder.convert(jsonBody); 
        // ignore: avoid_print
        print(responseCreateWallet);
        return responseCreateWallet;
      }
      ).catchError((e) {
        // ignore: avoid_print
        print("❌ Exception: $e");
        return null;
      });
  }

  deleteWallet(id) async {
    return await http
      .post(walletUrls.API_DELETE_WALLET(id))
      .then((http.Response response) {
        final String jsonBody = response.body;
        final int statusCode = response.statusCode;

        if(statusCode != 200){
          // ignore: avoid_print
          print(response.reasonPhrase);
          throw Exception("Error load api");
        }

        const JsonDecoder decoder = JsonDecoder();
        final useContainer = decoder.convert(jsonBody);
        final String responseCreateWallet = useContainer['results'];
        return responseCreateWallet;
      }
    );
  }
}