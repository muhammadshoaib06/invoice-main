import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_app/Cubits/CreateInvoiceCubit/create_invoice_state.dart';
import 'package:invoice_app/Cubits/FetchInvoiceCubit/fetch_invoice_cubit.dart';
import 'package:invoice_app/Data/Models/invoice.dart';
import 'package:invoice_app/Data/Repositories/invoices_repo.dart';
import 'package:invoice_app/View/Screens/update_invoice.dart';

class FetchInvoice extends StatefulWidget {
  const FetchInvoice({Key? key}) : super(key: key);

  @override
  State<FetchInvoice> createState() => _FetchInvoiceState();
}

class _FetchInvoiceState extends State<FetchInvoice> {
  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() async {
    await BlocProvider.of<FetchInvoiceCubit>(context).fetchInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Invoice'),
        centerTitle: true,
      ),
      body: SafeArea(child: BlocBuilder<FetchInvoiceCubit, FetchInvoiceState>(
        builder: (context, state) {
          if (state is FetchInvoiceInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is InvoiceFetched) {
            return state.invoice.isEmpty
                ? const Center(child: Text("Empty"))
                : Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListView.builder(
                        itemCount: state.invoice.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Invoice Number',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      state.invoice[index].invoiceNumber
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sender Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      state.invoice[index].senderName
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Receiver Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      state.invoice[index].receiverName
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateInvoice(
                                                        invoice: state
                                                            .invoice[index])));
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await InvoiceRepository.delete(
                                                state.invoice[index].invoiceId!)
                                            .then((value) {
                                          if (value) {
                                            BlocProvider.of<FetchInvoiceCubit>(
                                                    context)
                                                .fetchInvoice();
                                          }
                                        });
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  );
          }
          return Container();
        },
      )),
    );
  }
}
