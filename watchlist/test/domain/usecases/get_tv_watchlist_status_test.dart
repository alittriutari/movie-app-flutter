import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_tv_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvWatchlistStatus usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvWatchlistStatus(mockTvSeriesRepository);
  });

  const tId = 1;

  test('should get watchlist status from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(tId)).thenAnswer((_) async => true);
    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, true);
  });
}
