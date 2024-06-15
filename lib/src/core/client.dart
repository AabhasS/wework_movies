class Client<T> {
  // Endpoint for the call
  String url;

  // query param or post body depends on the call
  Map<String, dynamic>? param;

  // Data used only for put call
  // Because it needs type as dynamic
  dynamic data;

  // Data fetcher from response tree
  // decrypts the response Map with [parserKeys] to get actual data
  List<String>? parserKeys;

  /// can override entire headers value through
  /// Client() ..headers = {};
  Map<String, dynamic>? headers;

  Client(
      {required this.url,
      this.data,
      this.headers,
      this.param,
      this.parserKeys});

  static get({required String url}) => Client(url: url);



}
