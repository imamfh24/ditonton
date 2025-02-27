import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SslPinningHttpClient {
  static Future<http.Client> getClient() async {
    // Buat SecurityContext baru
    final SecurityContext context = SecurityContext();

    try {
      // Load sertifikat dari assets
      final ByteData certData =
          await rootBundle.load('certificates/themoviedb.pem');
      context.setTrustedCertificatesBytes(certData.buffer.asUint8List());
    } catch (e) {
      rethrow;
    }

    final HttpClient client = HttpClient(context: context);
    return IOClient(client);
  }
}
