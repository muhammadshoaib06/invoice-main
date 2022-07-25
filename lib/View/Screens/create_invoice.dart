import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_app/Cubits/CreateInvoiceCubit/create_invoice_state.dart';
import 'package:invoice_app/Cubits/FetchInvoiceCubit/fetch_invoice_cubit.dart';
import '../../Cubits/CreateInvoiceCubit/create_invoice_cubit.dart';
import 'package:invoice_app/Data/Models/invoice.dart';
import 'package:invoice_app/View/CustomerWidgets/text_field.dart';
import 'package:invoice_app/View/Screens/fetch_invoice.dart';

class CreateInvoice extends StatefulWidget {
  CreateInvoice({Key? key}) : super(key: key);

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  final TextEditingController invoiceNumberController = TextEditingController();

  final TextEditingController senderNameController = TextEditingController();

  final TextEditingController receiverNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isRecurring = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
        centerTitle: true,
      ),
      body: BlocListener<CreateInvoiceCubit, CreateInvoiceState>(
        listener: (context, state) {
          if (state is InvoiceCreatingError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry, some error occur')));
          }
          if (state is InvoiceCreated) {
            invoiceNumberController.clear();
            senderNameController.clear();
            receiverNameController.clear();
          }
        },
        child: ListView(
          children: [
            SizedBox(
              height: 10.sp,
            ),
            InvoiceTextField(
              hintText: 'Invoice Number',
              controller: invoiceNumberController,
            ),
            SizedBox(
              height: 10.sp,
            ),
            InvoiceTextField(
              hintText: 'Sender',
              controller: senderNameController,
            ),
            SizedBox(
              height: 10.sp,
            ),
            InvoiceTextField(
              hintText: 'Receiver',
              controller: receiverNameController,
            ),
            SizedBox(
              height: 10.sp,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<CreateInvoiceCubit>(context).createInvoice(
                  Invoice(
                      invoiceNumber: invoiceNumberController.text,
                      receiverName: receiverNameController.text,
                      senderName: senderNameController.text),
                );
              },
              child: Container(
                height: 30.sp,
                margin: EdgeInsets.symmetric(horizontal: 140.sp),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.sp),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Center(
                    child: BlocBuilder<CreateInvoiceCubit, CreateInvoiceState>(
                        builder: (context, state) {
                      if (state is InvoiceCreating) {
                        return SizedBox(
                          height: 20.sp,
                          width: 20.sp,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 1.5.sp,
                          ),
                        );
                      } else if (state is InvoiceCreated) {
                        return const Text('Create');
                      } else {
                        return const Text('Create');
                      }
                    }),
                  ),
                ),
              ),
            ),
            BlocBuilder<FetchInvoiceCubit, FetchInvoiceState>(
              builder: (context, state) {
                if (state is InvoiceFetching) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FetchInvoice()),
                    );
                  },
                  child: const Text(
                    'Fetch Invoice',
                    style: TextStyle(fontSize: 22),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
