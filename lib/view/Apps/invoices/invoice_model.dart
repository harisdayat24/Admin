class InvoiceList {
  int userId;
  String invoiceId;
  String date;
  String billname;
  String amount;
  String status;
  bool isCheck;

  InvoiceList({
    required this.isCheck,
    required this.userId,
    required this.invoiceId,
    required this.date,
    required this.billname,
    required this.amount,
    required this.status,
  });
}

class InvoiceListName {
  String invoiceId;
  String date;
  String billingname;
  String amount;
  String status;
  String pdf;
  String actions;
  // bool isCheck;

  InvoiceListName({
    // required this.isCheck,
    required this.actions,
    required this.pdf,
    required this.invoiceId,
    required this.date,
    required this.billingname,
    required this.amount,
    required this.status,
  });
}
