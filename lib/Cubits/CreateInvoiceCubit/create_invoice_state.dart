import 'package:equatable/equatable.dart';
import 'package:invoice_app/Data/Models/invoice.dart';

abstract class CreateInvoiceState extends Equatable {
  const CreateInvoiceState();
}

class CreateInvoiceInitial extends CreateInvoiceState {
  @override
  List<Object> get props => [];
}

class InvoiceCreating extends CreateInvoiceState {
  @override
  List<Object> get props => [];
}

class InvoiceCreated extends CreateInvoiceState {
  @override
  List<Object> get props => [];
}

class InvoiceCreatingError extends CreateInvoiceState {
  @override
  List<Object> get props => [];
}
