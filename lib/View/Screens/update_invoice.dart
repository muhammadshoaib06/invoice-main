import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_app/Cubits/FetchInvoiceCubit/fetch_invoice_cubit.dart';
import 'package:invoice_app/Data/Models/invoice.dart';
import 'package:invoice_app/Data/Repositories/invoices_repo.dart';
import 'package:invoice_app/View/CustomerWidgets/text_field.dart';
import 'package:invoice_app/View/Screens/fetch_invoice.dart';

class UpdateInvoice extends StatefulWidget {
  Invoice invoice;

  UpdateInvoice({required this.invoice}) : super();

  @override
  State<UpdateInvoice> createState() => _UpdateInvoiceState();
}

class _UpdateInvoiceState extends State<UpdateInvoice> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController invoiceNumber =
        TextEditingController(text: widget.invoice.invoiceNumber);
    final TextEditingController sender =
        TextEditingController(text: widget.invoice.senderName);
    final TextEditingController receiver =
        TextEditingController(text: widget.invoice.receiverName);
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: 10.sp,
        ),
        InvoiceTextField(
          hintText: 'Invoice Number',
          controller: invoiceNumber,
        ),
        SizedBox(
          height: 10.sp,
        ),
        InvoiceTextField(
          hintText: 'Sender',
          controller: sender,
        ),
        SizedBox(
          height: 10.sp,
        ),
        InvoiceTextField(
          hintText: 'Receiver',
          controller: receiver,
        ),
        SizedBox(
          height: 10.sp,
        ),
        InkWell(
          onTap: (() async {
            Invoice invoice = Invoice(
                invoiceNumber: invoiceNumber.text,
                receiverName: receiver.text,
                senderName: sender.text);
            await InvoiceRepository.updated(invoice, widget.invoice.invoiceId!)
                .then((value) {
              BlocProvider.of<FetchInvoiceCubit>(context).fetchInvoice();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FetchInvoice()),
              );
            });
          }),
          child: Container(
            height: 30.sp,
            margin: EdgeInsets.symmetric(horizontal: 140.sp),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.sp),
            ),
            child: Text('Update'),
          ),
        )
      ],
    ));
  }
}
