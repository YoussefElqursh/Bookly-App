part of 'featured_list_cubit.dart';

@immutable
sealed class FeaturedListState {}

final class FeaturedListInitial extends FeaturedListState {}
final class FeaturedListLoading extends FeaturedListState {}
final class FeaturedListFailure extends FeaturedListState {
  final String message;

  FeaturedListFailure(this.message);
}
final class FeaturedListSuccess extends FeaturedListState {
  final List<BookModel> books;

  FeaturedListSuccess(this.books);
}
