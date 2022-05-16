import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_app/main.dart' as app;

import 'robots/home_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  HomeRobot homeRobot;

  group('end-to-end test', () {
    testWidgets('movie app', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      homeRobot = HomeRobot(tester);

//see popular movie
      await homeRobot.clickShowPopularMovie();

//see top rated movie
      await homeRobot.clickShowTopRatedMovie();
    });
  });
}
