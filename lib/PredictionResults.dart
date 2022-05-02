import 'dart:convert';

class predictionResults {
    final String filename;
    final String results;
  
    const predictionResults({required this.filename, required this.results});
  
    factory predictionResults.fromJson(Map<String, dynamic> json) {
      return predictionResults(
        filename: json['filename'] as String,
        results: json['results'] as String,
      );
    }
}
  
  List<predictionResults> parseResults(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<predictionResults>((json) => predictionResults.fromJson(json))
        .toList();
  }
