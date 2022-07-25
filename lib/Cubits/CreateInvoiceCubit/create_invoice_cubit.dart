import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice_app/Data/Models/invoice.dart';
import 'package:invoice_app/Data/Repositories/invoices_repo.dart';

import 'create_invoice_state.dart';

class CreateInvoiceCubit extends Cubit<CreateInvoiceState> {
  final InvoiceRepository invoiceRepository;

  CreateInvoiceCubit({required this.invoiceRepository})
      : super(CreateInvoiceInitial());

  createInvoice(Invoice invoice) async {
    emit(InvoiceCreating());
    try {
      final isInvoiceCreated = await invoiceRepository.createInvoice(invoice);
      if (isInvoiceCreated) {
        emit(InvoiceCreated());
      } else {
        emit(InvoiceCreatingError());
      }
    } catch (e) {
      print(e);
      emit(InvoiceCreatingError());
    }
  }

  // fetchInvoice() async {
  //   emit(InvoiceFetching());
  //   try {
  //     final invoicefetched = await invoiceRepository.fetchInvoice();
  //     if (invoicefetched != null) {
  //       emit(InvoiceFetched(invoice: invoicefetched));
  //     } else {
  //       emit(InvoicefetchingError());
  //     }
  //   } catch (e) {
  //     print(e);
  //     emit(InvoicefetchingError());
  //   }
  // }
}
