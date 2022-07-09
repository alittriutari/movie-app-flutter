// import 'dart:io';

// import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

// Future<SecurityContext> get globalContext async {
//   final sslCert = await rootBundle.load('certificate/certificate.pem');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   return securityContext;
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
