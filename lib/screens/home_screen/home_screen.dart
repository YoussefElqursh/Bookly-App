import 'package:bookly_app/bloc/featured_list_cubit.dart';
import 'package:bookly_app/bloc/newest_list_cubit.dart';
import 'package:bookly_app/data/book_model.dart';
import 'package:bookly_app/screens/book_details_screen/book_details_screen.dart';
import 'package:bookly_app/screens/home_screen/widget/featured_list_widget.dart';
import 'package:bookly_app/screens/home_screen/widget/rating_review_widget.dart';
import 'package:bookly_app/shared/style/styles.dart';
import 'package:bookly_app/shared/widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: appBarWidget(context: context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: buildFeaturedBookList(context),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Newest Books',
                    style: Styles.titleMedium18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BlocBuilder<NewestListCubit, NewestListState>(
                builder: (context, state) {
                  if(state is NewestListSuccess){
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: buildBestSellerBookList(context: context, book: state.books[index],),
                      ),
                    );
                  }else if(state is NewestListFailure){
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder<FeaturedListCubit, FeaturedListState> buildFeaturedBookList(
      BuildContext context) {
    return BlocBuilder<FeaturedListCubit, FeaturedListState>(
      builder: (context, state) {
        if (state is FeaturedListSuccess) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: featuredListWidget(
                  context: context,
                  imageUrl:
                      state.books[index].volumeInfo?.imageLinks?.thumbnail ??
                          '',
                ),
              ),
              itemCount: state.books.length,
            ),
          );
        }
        if (state is FeaturedListFailure) {
          return Center(child: Text(state.message));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  GestureDetector buildBestSellerBookList({required BuildContext context, required BookModel book}) {
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
                    book.volumeInfo?.authors?.first ?? '',
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
