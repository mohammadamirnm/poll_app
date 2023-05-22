import 'package:http/http.dart' as http;
import 'package:poll_app/src/features/poll/data/models/poll_model.dart';

import '../exceptions/poll_api_exceptions.dart';

class PollApiClient {
  PollApiClient({
    // dependency injection is needed for easier testing with mocking the client or any other needed property
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  // the api key needs to be stored safely, I would add the key as an environment variable and add the .env file to .gitignore in a real project.
  static const String _baseUrl = 'https://firebasestorage.googleapis.com';
  static const String _token = '48258028-2f77-493d-9e9d-8ca322b3068a';

  final http.Client _httpClient;

  Future<PollModel> getPollModel() async {
    final Uri pollRequest = Uri.parse(
      '$_baseUrl/v0/b/healy-identity.appspot.com/o/polls%2FvAJax5hdbF.json?alt=media&token=$_token',
    );

    final http.Response response = await _httpClient.get(
      pollRequest,
    );

    if (response.statusCode != 200) {
      throw PollRequestFailed();
    }

    final PollModel pollModel = pollModelFromJson(response.body);

    return pollModel;
  }
}
