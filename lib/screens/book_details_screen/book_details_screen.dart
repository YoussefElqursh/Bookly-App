import 'package:bookly_app/bloc/featured_list_cubit.dart';
import 'package:bookly_app/data/book_model.dart';
import 'package:bookly_app/screens/home_screen/widget/featured_list_widget.dart';
import 'package:bookly_app/screens/home_screen/widget/rating_review_widget.dart';
import 'package:bookly_app/shared/style/styles.dart';
import 'package:bookly_app/shared/widget/custom_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.17),
                child: Align(
                  alignment: Alignment.center,
                  child: featuredListWidget(
                      context: context,
                      imageUrl:
                          bookModel.volumeInfo?.imageLinks?.thumbnail ?? ''),
                ),
              ),
              const SizedBox(
                height: 43,
              ),
              Text(
                bookModel.volumeInfo?.title ?? '',
                style:
                    Styles.titleMedium30.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 6,
              ),
              Opacity(
                opacity: 0.7,
                child: Text(
                  bookModel.volumeInfo?.authors?.first ?? '',
                  style: Styles.titleMedium18.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              buildRatingWidget(),
              const SizedBox(
                height: 37,
              ),
              Row(
                children: [
                  Expanded(
                    child: buildCustomButton(
                      context: context,
                      text: 'Free',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      onPressed: (){},
                    ),
                  ),
                  Expanded(
                    child: buildCustomButton(
                      context: context,
                      text: 'Free Preview',
                      backgroundColor: const Color(0xFFEF8262),
                      textColor: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      onPressed: () async {
                      Uri url = Uri.parse(bookModel.volumeInfo!.previewLink!);
                      if(!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      };
                    },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'You can also like',
                  style: Styles.titleMedium14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: BlocBuilder<FeaturedListCubit, FeaturedListState>(
                  builder: (context, state) {
                    if (state is FeaturedListSuccess) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: featuredListWidget(
                            context: context,
                            imageUrl: state.books[index].volumeInfo?.imageLinks!
                                    .thumbnail ??
                                '',
                          ),
                        ),
                        itemCount: state.books.length,
                      );
                    }
                    if (state is FeaturedListFailure) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
