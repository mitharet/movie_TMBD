import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_response.dart';

class MovieService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '612b6d84b376f049efc9e145cd47d430'; // Ganti dengan api Key personal

  Future<MovieResponse> fetchNowPlaying(int page) async {
    final url = Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieResponse.fromJson(data);
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}