import 'package:flutter_test/flutter_test.dart';
import 'package:hobby_hive/widgets/loading_indicator.dart';
import 'extensions.dart';

void main() {
  testWidgets('LoadingIndicator', (WidgetTester tester) async {
    await tester.pumpWidget(const LoadingIndicator().material);
  });
}
