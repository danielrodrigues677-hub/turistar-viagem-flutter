import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turistar_viagem/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('renders home screen', (tester) async {
    await tester.pumpWidget(const TuristarViagemApp());

    expect(find.text('Explore o Mundo'), findsOneWidget);
    expect(find.text('Buscar Voos'), findsWidgets);
  });
}
