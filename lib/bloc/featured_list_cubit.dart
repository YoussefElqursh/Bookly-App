import 'package:bookly_app/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookly_app/data/book_model.dart';
import 'package:meta/meta.dart';

part 'featured_list_state.dart';

class FeaturedListCubit extends Cubit<FeaturedListState> {
  FeaturedListCubit(this.homeRepo) : super(FeaturedListInitial());

  final HomeRepo homeRepo;

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedListLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold(
      (failure) => emit(FeaturedListFailure(failure.message)),
      (books) => emit(FeaturedListSuccess(books)),
    );
  }
}
