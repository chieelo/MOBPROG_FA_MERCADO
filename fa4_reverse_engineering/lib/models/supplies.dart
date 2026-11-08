class Supply {
  final String id;
  final String name;
  final int quantity;
  final String unitPrice;
  final String parameterClassId;

  const Supply({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.parameterClassId,
  });

  double get totalPrice => quantity * double.parse(unitPrice);

  static Object _formatPrice(double price) =>
    price == price.truncateToDouble()
        ? price.toInt().toString()
        : price.toString;

  String get computedPrice =>
      '\$${_formatPrice(totalPrice)} X $quantity = \$${_formatPrice(totalPrice)}';

}