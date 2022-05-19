import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/network_info.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  test('is connected', () async {
    //assert
    when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);
    //act
    final result = await networkInfo.isConnected;
    //assert
    expect(result, true);
  });

  test('is disconnected', () async {
    //assert
    when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => false);
    //act
    final result = await networkInfo.isConnected;
    //assert
    expect(result, false);
  });
}
