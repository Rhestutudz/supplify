import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/order_model.dart';
import '../models/order_item_model.dart';

class InvoiceService {
  static Future<Uint8List> generateInvoice(
    Order order,
    List<OrderItem> items,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header(),
              pw.SizedBox(height: 24),
              _orderInfo(order),
              pw.SizedBox(height: 24),
              _table(items),
              pw.Divider(),
              _total(items),
              pw.SizedBox(height: 24),
              _footer(),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // ================= HEADER =================
  static pw.Widget _header() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'SUPPLIIFY',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text('Distributor Management System'),
          ],
        ),
        pw.Text(
          'INVOICE',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ================= INFO =================
  static pw.Widget _orderInfo(Order order) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Order ID : ${order.id}'),
          pw.Text('Customer : ${order.customerName}'),
          pw.Text('Tanggal  : ${order.createdAt}'),
          pw.Text('Status   : ${order.status.toUpperCase()}'),
        ],
      ),
    );
  }

  // ================= TABLE =================
  static pw.Widget _table(List<OrderItem> items) {
    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: const pw.FlexColumnWidth(4),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            _cell('Produk', bold: true),
            _cell('Qty', bold: true),
            _cell('Harga', bold: true),
            _cell('Subtotal', bold: true),
          ],
        ),
        ...items.map(
          (item) => pw.TableRow(
            children: [
              _cell(item.productName),
              _cell(item.qty.toString()),
              _cell('Rp ${item.price.toStringAsFixed(0)}'),
              _cell(
                'Rp ${(item.qty * item.price).toStringAsFixed(0)}',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _cell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  // ================= TOTAL =================
  static pw.Widget _total(List<OrderItem> items) {
    final total = items.fold<double>(
      0,
      (sum, item) => sum + (item.qty * item.price),
    );

    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'TOTAL: Rp ${total.toStringAsFixed(0)}',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  // ================= FOOTER =================
  static pw.Widget _footer() {
    return pw.Center(
      child: pw.Text(
        'Terima kasih telah bertransaksi dengan Suppliify',
        style: const pw.TextStyle(fontSize: 10),
      ),
    );
  }
}
