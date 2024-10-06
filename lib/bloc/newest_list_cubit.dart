import 'package:bloc/bloc.dart';
import 'package:bookly_app/data/book_model.dart';
import 'package:bookly_app/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'newest_list_state.dart';

class NewestListCubit extends Cubit<NewestListState> {
  NewestListCubit(this.homeRepo) : super(NewestListInitial());

  final HomeRepo homeRepo;

  Future<void> fetchNewestBooks() async {
    emit(NewestListLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold(
          (failure) => emit(NewestListFailure(failure.message)),
          (books) => emit(NewestListSuccess(books)),
    );
  }
}
