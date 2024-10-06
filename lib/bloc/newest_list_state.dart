part of 'newest_list_cubit.dart';

@immutable
sealed class NewestListState {}

final class NewestListInitial extends NewestListState {}
final class NewestListLoading extends NewestListState {}
final class NewestListFailure extends NewestListState {
  final String message;

  NewestListFailure(this.message);
}
final class NewestListSuccess extends NewestListState {
  final List<BookModel> books;

  NewestListSuccess(this.books);
}
