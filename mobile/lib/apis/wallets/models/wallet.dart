
class Wallet {
  Wallet({
    required this.id,
    required this.nameWallet,
    required this.typeWallet,
    required this.currency,
    required this.amount
  });

  final String id;
  final String nameWallet;
  final String typeWallet;
  final String currency;
  final int amount;

  const Wallet.empty()
      : id = '',
        nameWallet = '',
        typeWallet = '',
        currency = '',
        amount = 0;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json['id'],
    nameWallet: json['nameWallet'],
    typeWallet: json['typeWallet'],
    currency: json['currency'],
    amount: json['amount'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameWallet': nameWallet,
    'typeWallet': typeWallet,
    'currency': currency,
    'amount': amount,
  };
}