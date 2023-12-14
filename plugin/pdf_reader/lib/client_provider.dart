import 'package:http/http.dart' show Client;

class ClientProvider {
  final Client _client;
  static ClientProvider? _instance;

  /// defaults to the standard dart http client
  ClientProvider._create(Client? client) : this._client = client ?? Client();

  factory ClientProvider({Client? client}) =>
      _instance ?? (_instance = ClientProvider._create(client));

  Client get client => _client;
}
