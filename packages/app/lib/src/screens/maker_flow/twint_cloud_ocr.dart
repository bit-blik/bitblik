import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

/// OCR.space's documented shared development key. Production builds can
/// override it with `--dart-define=OCR_SPACE_API_KEY=...`.
const _ocrSpaceApiKey = String.fromEnvironment(
  'OCR_SPACE_API_KEY',
  defaultValue: 'helloworld',
);

/// Sends a user-approved image to OCR.space and returns extracted text.
/// Callers must obtain explicit consent before calling this function.
Future<String?> recognizeTwintScreenshotOnline(PlatformFile image) async {
  final request =
      http.MultipartRequest(
          'POST',
          Uri.parse('https://api.ocr.space/parse/image'),
        )
        ..headers['apikey'] = _ocrSpaceApiKey
        ..fields.addAll({
          'language': 'eng',
          'OCREngine': '2',
          'scale': 'true',
          'isOverlayRequired': 'false',
        })
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            await image.readAsBytes(),
            filename: image.name,
          ),
        );

  final response = await request.send().timeout(const Duration(seconds: 20));
  if (response.statusCode != 200) return null;
  final body = jsonDecode(await response.stream.bytesToString());
  if (body is! Map<String, dynamic> || body['IsErroredOnProcessing'] == true) {
    return null;
  }
  final results = body['ParsedResults'];
  if (results is! List) return null;
  return results
      .whereType<Map>()
      .map((result) => result['ParsedText'])
      .whereType<String>()
      .join('\n');
}
