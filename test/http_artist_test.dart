import 'package:flutter_test/flutter_test.dart';
import 'package:i_tunes/main.dart';

void main() {
  test('getITunesUri should get API iTunes Music in Uri type', () {
    String term = "jake";
    Uri iTunesUri = getITunesUri(term);

    expect(iTunesUri.toString(),
        "https://itunes.apple.com/search?media=music&term=jake");
    expect(iTunesUri is Uri, true);
  });
}
