import 'package:bookly_app/bloc/featured_list_cubit.dart';
import 'package:bookly_app/data/book_model.dart';
import 'package:bookly_app/screens/book_details_screen/book_details_screen.dart';
import 'package:bookly_app/screens/home_screen/widget/rating_review_widget.dart';
import 'package:bookly_app/shared/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBarWidget(context: context),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Search Result',
                style: Styles.titleMedium18,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: buildSearchResultWidget(context: context),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchBarWidget({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          suffixIcon: const Icon(
            Icons.search_outlined,
            size: 22.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  buildSearchResultWidget({required BuildContext context}) {
    return BlocBuilder<FeaturedListCubit,FeaturedListState>(
      builder: (context, state) {
        if(state is FeaturedListSuccess){
          return ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildResultBookList(context, state.books[index]),
            ),
          );
        }
        if(state is FeaturedListFailure){
          return Center(child: Text(state.message));
        }
        return const Center(child: CircularProgressIndicator());
    },
    );
  }

  GestureDetector buildResultBookList(BuildContext context, BookModel book) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsScreen(bookModel: book,),
        ),
      ),
      child: SizedBox(
        height: 125,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2.5 / 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(book.volumeInfo?.imageLinks?.thumbnail ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: Text(
                      book.volumeInfo?.title ?? '',
                      style: Styles.titleMedium20.copyWith(fontFamily: 'GT'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                      book.volumeInfo?.authors?[0] ?? '',
                    style: Styles.titleMedium14,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        'Free',
                        style: Styles.titleMedium20
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      buildRatingWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
