import 'dart:async';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'anyinspect_http_client_request.dart';
import 'anyinspect_http_interceptor.dart';

class AnyInspectHttpClient implements HttpClient {
  HttpClient client;
  AnyInspectHttpInterceptor interceptor;

  AnyInspectHttpClient(
    this.client,
    this.interceptor,
  );

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  Duration? connectionTimeout;

  @override
  int? maxConnectionsPerHost;

  @override
  bool autoUncompress = true;

  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> open(
      String method, String host, int port, String path) {
    return withInterceptor(client.open(method, host, port, path));
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    return withInterceptor(client.openUrl(method, url));
  }

  @override
  Future<HttpClientRequest> get(String host, int port, String path) {
    return open('get', host, port, path);
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) {
    return openUrl('get', url);
  }

  @override
  Future<HttpClientRequest> post(String host, int port, String path) {
    return open('post', host, port, path);
  }

  @override
  Future<HttpClientRequest> postUrl(Uri url) {
    return openUrl('post', url);
  }

  @override
  Future<HttpClientRequest> put(String host, int port, String path) {
    return open('put', host, port, path);
  }

  @override
  Future<HttpClientRequest> putUrl(Uri url) {
    return openUrl('put', url);
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) {
    return open('delete', host, port, path);
  }

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) {
    return openUrl('delete', url);
  }

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) {
    return open('patch', host, port, path);
  }

  @override
  Future<HttpClientRequest> patchUrl(Uri url) {
    return openUrl('patch', url);
  }

  @override
  Future<HttpClientRequest> head(String host, int port, String path) {
    return open('head', host, port, path);
  }

  @override
  Future<HttpClientRequest> headUrl(Uri url) {
    return openUrl('head', url);
  }

  @override
  set authenticate(Future<bool> f(Uri url, String scheme, String? realm)?) {
    client.authenticate = f;
  }

  @override
  void addCredentials(
      Uri url, String realm, HttpClientCredentials credentials) {
    client.addCredentials(url, realm, credentials);
  }

  @override
  set findProxy(String f(Uri url)?) {
    client.findProxy = f;
  }

  @override
  set authenticateProxy(
      Future<bool> f(String host, int port, String scheme, String? realm)?) {
    client.authenticateProxy = f;
  }

  @override
  void addProxyCredentials(
      String host, int port, String realm, HttpClientCredentials credentials) {
    client.addProxyCredentials(host, port, realm, credentials);
  }

  @override
  set badCertificateCallback(
      bool callback(X509Certificate cert, String host, int port)?) {
    client.badCertificateCallback = callback;
  }

  @override
  void close({bool force: false}) {
    client.close(force: force);
  }
  
  void set connectionFactory(
        Future<ConnectionTask<Socket>> Function(
                Uri url, String? proxyHost, int? proxyPort)?
            f) =>
    throw UnsupportedError("connectionFactory not implemented");

  void set keyLog(Function(String line)? callback) =>
    throw UnsupportedError("keyLog not implemented");

  Future<AnyInspectHttpClientRequest> withInterceptor(
      Future<HttpClientRequest> future) async {
    HttpClientRequest request = await future;

    return AnyInspectHttpClientRequest(
      interceptor,
      Uuid().v4(),
      request,
    );
  }
}
