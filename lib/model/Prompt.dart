import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  final String apiKey = 'API_KEY'; // Substitua pela sua chave de API

  // Exemplo de texto para enviar à API
  final String prompt = 'Testando GPT';

  // URL da API do GPT-3.5
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  // Cabeçalhos necessários para autenticação na API
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  // Corpo da requisição para enviar o prompt à API
  final Map<String, dynamic> data = {
    'prompt': prompt,
    'max_tokens': 50,
    'temperature': 0.7,
  };

  // Envio da requisição à API do GPT-3.5
  http
      .post(
    Uri.parse(apiUrl),
    headers: headers,
    body: jsonEncode(data),
  )
      .then((response) {
    if (response.statusCode == 200) {
      // Parse da resposta JSON
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final String completion = jsonResponse['choices'][0]['text'];

      // Exibindo a resposta do GPT
      print('Resposta do GPT: $completion');
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  }).catchError((error) {
    print('Erro: $error');
  });
}
