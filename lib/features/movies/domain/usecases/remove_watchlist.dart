import 'package:dartz/dartz.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
