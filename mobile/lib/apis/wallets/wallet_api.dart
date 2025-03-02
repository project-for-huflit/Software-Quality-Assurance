import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/apis/wallets/constants/wallet_url.dart';

import 'package:mobile/apis/wallets/models/wallet_model.dart';

class WalletServices{
  Future<List<WalletModel>> listWallet() {
    return http
        .get(WalletUrls().API_WALLET_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
 
      if(statusCode != 200){
        // ignore: avoid_print
        print(response.reasonPhrase);
        throw Exception("Error load api");
      }
 
      const JsonDecoder decoder = JsonDecoder();
      final useListContainer = decoder.convert(jsonBody);
      final List walletList = useListContainer['results'];
      return walletList.map((contactRaw) => WalletModel.fromJson(contactRaw)).toList();
    });
  }

  createWallet(data) async {
    return await http
      .post(
        WalletUrls().API_CREATE_WALLET,
        body: data,
      )
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

  deleteWallet(data) async {
    return await http
      .post(
        WalletUrls().API_DELETE_WALLET,
        body: data,
      )
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