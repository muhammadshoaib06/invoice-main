import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_app/Cubits/FetchInvoiceCubit/fetch_invoice_cubit.dart';
import 'package:invoice_app/Data/Repositories/invoices_repo.dart';

import 'Cubits/CreateInvoiceCubit/create_invoice_cubit.dart';
import 'View/Screens/create_invoice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//g
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<CreateInvoiceCubit>(
            create: (context) =>
                CreateInvoiceCubit(invoiceRepository: InvoiceRepository()),
          ),
          BlocProvider<FetchInvoiceCubit>(
            create: (context) =>
                FetchInvoiceCubit(invoiceRepository: InvoiceRepository()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CreateInvoice(),
        ),
      ),
    );
  }
}
