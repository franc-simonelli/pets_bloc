import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petsguide/bloc/details/bloc/details_bloc.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/screen/details/widget/favorite_widget.dart';
import 'package:petsguide/screen/widget/loading_widget.dart';

class InformationCatWidget extends StatelessWidget {
  const InformationCatWidget(this.cat, {super.key});

  final Cats cat;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cat.razza!,
                                  style: theme.textTheme.labelLarge),
                            ],
                          ),
                          const SizedBox(height: 5),
                          buildRow(theme, FontAwesomeIcons.heartbeat,
                              'Vita media: ', cat.vita!),
                          const SizedBox(height: 5),
                          buildRow(theme, Icons.open_in_full_outlined,
                              'Taglia: ', cat.taglia!),
                          const SizedBox(height: 5),
                          buildRow(theme, Icons.category, 'Mantello: ',
                              cat.mantello!),
                          const SizedBox(height: 5),
                          buildRow(theme, FontAwesomeIcons.globe, 'Paese: ',
                              cat.paese!),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 25,
                                    color: Color.fromARGB(255, 250, 142, 47),
                                  ),
                                  const SizedBox(width: 5),
                                  BlocProvider(
                                    create: (context) => DetailsBloc()..add(GetPunteggioMedioEvent(cat.id)),  
                                    child: BlocBuilder<DetailsBloc, DetailsState>(
                                      builder: (context, state) {
                                        if (state is GetPunteggioMedioState) {
                                          return GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<DetailsBloc>(context)
                                                .add(SetNewPunteggioEvent(5.0, cat.id));
                                            },
                                            child: Text(
                                                state.punteggioMedio.toString(),
                                                style: theme
                                                    .textTheme.labelLarge!),
                                          );
                                        } else if (state
                                            is LoadingSetPunteggioState) {
                                          return const LoadingWidget(40.0);
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: InkWell(
                          onTap: (() async {
                            return showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(36),
                                    topRight: Radius.circular(36)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetWidget(cat);
                              },
                            );
                          }),
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: theme.primaryColor.withOpacity(0.8),
                            ),
                            child: Center(
                              child: Text('Vota',
                                  style: theme.textTheme.labelMedium!
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: FavoriteWidget(cat)
                      )
                    ]),
                  ),
                ),
              )),
        ));
  }

  Widget buildRow(theme, icon, label, value) {
    return Row(
      children: [
        Icon(icon, color: theme.primaryColor, size: 17),
        const SizedBox(width: 10),
        Text(label,
            style: theme.textTheme.labelMedium.copyWith(color: Colors.white)),
        Text(value,
            style: theme.textTheme.labelMedium.copyWith(color: Colors.white))
      ],
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget(
    this.cat, {
    Key? key,
  }) : super(key: key);

  final Cats cat;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double ratingUpdate = 0.0;
    return SizedBox(
        height: 220,
        child: Column(children: [
          const SizedBox(height: 20),
          Container(
            width: 60,
            height: 3,
            color: theme.primaryColor,
          ),
          const SizedBox(height: 20),
          Text('Vota questo micio!', style: theme.textTheme.displayMedium),
          const SizedBox(height: 20),
          BlocProvider(
            create: (context) =>
                DetailsBloc()..add(GetInitialRatingEvent(cat.id)),
            child: BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is GetInitialRatingState) {
                  return RatingBar.builder(
                    unratedColor: Colors.grey,
                    itemSize: 40,
                    initialRating: state.initialRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 248, 140, 45),
                    ),
                    onRatingUpdate: (rating) {
                      // catController.setRatingSelected(rating);
                      ratingUpdate = rating;
                    },
                  );
                } else {
                  return const LoadingWidget(80.0);
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
              onTap: () async {
                BlocProvider.of<DetailsBloc>(context)
                    .add(SetNewPunteggioEvent(ratingUpdate, cat.id));
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: theme.primaryColor),
                child: Center(
                    child: Text('Conferma', style: theme.textTheme.labelLarge)),
              ))
        ]));
  }
}
