class Transaction {
  String trxId;
  String time;
  String totalPrice;

  Transaction(
      {required this.trxId, required this.totalPrice, required this.time});

  factory Transaction.fromJson(Map<dynamic, dynamic> json) {
    return Transaction(
      trxId: json['trxId'],
      time: json['time'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'trxId': trxId, 'time': time, 'totalPrice': totalPrice};
  }
}
