import 'dart:convert';

class OrderHistory {
  final String symbol;
  final String price;
  final int volume;
  final int derivativeAmount;
  final String status;
  final String date;
  OrderHistory({
    required this.symbol,
    required this.price,
    required this.volume,
    required this.derivativeAmount,
    required this.status,
    required this.date,
  });

  OrderHistory copyWith({
    String? symbol,
    String? price,
    int? volume,
    int? derivativeAmount,
    String? status,
    String? date,
  }) {
    return OrderHistory(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      volume: volume ?? this.volume,
      derivativeAmount: derivativeAmount ?? this.derivativeAmount,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'price': price,
      'volume': volume,
      'derivativeAmount': derivativeAmount,
      'status': status,
      'date': date,
    };
  }

  factory OrderHistory.fromMap(Map<String, dynamic> map) {
    return OrderHistory(
      symbol: map['symbol'],
      price: map['price'],
      volume: map['volume']?.toInt(),
      derivativeAmount: map['derivativeAmount']?.toInt(),
      status: map['status'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistory.fromJson(String source) =>
      OrderHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderHistory(symbol: $symbol, price: $price, volume: $volume, derivativeAmount: $derivativeAmount, status: $status, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderHistory &&
        other.symbol == symbol &&
        other.price == price &&
        other.volume == volume &&
        other.derivativeAmount == derivativeAmount &&
        other.status == status &&
        other.date == date;
  }

  @override
  int get hashCode {
    return symbol.hashCode ^
        price.hashCode ^
        volume.hashCode ^
        derivativeAmount.hashCode ^
        status.hashCode ^
        date.hashCode;
  }
}
