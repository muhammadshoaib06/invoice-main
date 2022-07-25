part of 'fetch_invoice_cubit.dart';

abstract class FetchInvoiceState extends Equatable {
  const FetchInvoiceState();
}

class FetchInvoiceInitial extends FetchInvoiceState {
  @override
  List<Object> get props => [];
}

class InvoiceFetching extends FetchInvoiceState {
  @override
  List<Object> get props => [];
}

class InvoiceFetched extends FetchInvoiceState {
  List<Invoice> invoice;
  InvoiceFetched({required this.invoice});
  @override
  List<Object> get props => [invoice];
}

class InvoicefetchingError extends FetchInvoiceState {
  @override
  List<Object> get props => [];
}
