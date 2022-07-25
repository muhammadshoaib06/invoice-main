import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice_app/Data/Models/invoice.dart';
import 'package:invoice_app/Data/Repositories/invoices_repo.dart';

part 'fetch_invoice_state.dart';

class FetchInvoiceCubit extends Cubit<FetchInvoiceState> {
  final InvoiceRepository invoiceRepository;
  FetchInvoiceCubit({required this.invoiceRepository})
      : super(FetchInvoiceInitial());
  StreamSubscription? firebaseListStream;

  List<Invoice>? missings;

  fetchInvoice() async {
    try {
      emit(FetchInvoiceInitial());

      await invoiceRepository.fetchInvoice().then((invoicefetched) {
        if (invoicefetched != null) {
          emit(InvoiceFetched(invoice: invoicefetched));
        } else {
          emit(InvoicefetchingError());
        }
      });
    } catch (e) {
      print(e);
      emit(InvoicefetchingError());
    }
  }

  Future<List<Invoice>?> getMissingListStream() async {
    emit(FetchInvoiceInitial());
    try {
      Stream<List<Invoice>>? InvoiceStream =
          await invoiceRepository.fetchInvoiceStream();
      if (InvoiceStream != null) {
        firebaseListStream = InvoiceStream.listen((dataSnapshot) {
          if (dataSnapshot.isNotEmpty) {
            missings = dataSnapshot;
            emit(InvoiceFetched(invoice: missings!));
          } else {
            emit(InvoicefetchingError());
          }
        });
      } else {
        emit(InvoicefetchingError());
      }
      return missings;
    } catch (e) {
      print(e);
      emit(InvoicefetchingError());
    }
  }

  @override
  Future<void> close() async {
    await firebaseListStream!.cancel();
    return super.close();
  }
}
