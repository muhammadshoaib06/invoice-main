import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_app/Data/Models/invoice.dart';

class InvoiceRepository {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static CollectionReference invoicesCollection =
      _fireStore.collection('invoices');

  Future<bool> createInvoice(Invoice invoice) async {
    final docId = invoicesCollection.doc().id;
    try {
      await invoicesCollection.doc(docId).set({
        'id': docId,
        'invoice_number': invoice.invoiceNumber,
        'sender_name': invoice.senderName,
        'receiver_name': invoice.receiverName
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Invoice>> fetchInvoice() async {
    List<Invoice> invoiceList = [];
    await invoicesCollection.snapshots().listen((event) {
      event.docs.forEach((element) {
        invoiceList.add(Invoice.fromMap(element));
      });
    });
    return invoiceList;
  }

  Future<List<Invoice>?> fetchInvoice2() async {
    List<Invoice> missingPersonList = [];
    try {
      QuerySnapshot querySnapshot = await invoicesCollection.get();

      for (var document in querySnapshot.docs) {
        Invoice missingPerson = Invoice.fromMap(document);
        missingPersonList.add(missingPerson);
      }

      return missingPersonList;
    } catch (e) {
      return null;
    }
  }

  Future<Stream<List<Invoice>>?> fetchInvoiceStream() async {
    try {
      return invoicesCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((usersDocs) => Invoice.fromMap(usersDocs))
            .toList();
      });
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updated(Invoice invoice, String id) async {
    try {
      await invoicesCollection.doc(id).update({
        'id': id,
        'invoice_number': invoice.invoiceNumber,
        'sender_name': invoice.senderName,
        'receiver_name': invoice.receiverName
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> delete(String id) async {
    try {
      await invoicesCollection.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
