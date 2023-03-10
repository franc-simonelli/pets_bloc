import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:petsguide/bloc/details/bloc/details_bloc.dart';
import 'package:petsguide/bloc/punteggi/punteggi_bloc.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/screen/home/widget/image_widget.dart';
import 'package:petsguide/screen/widget/app_bar_widget.dart';
import 'package:petsguide/screen/widget/loading_widget.dart';

class PunteggiScreen extends StatefulWidget {
  const PunteggiScreen({super.key});

  @override
  State<PunteggiScreen> createState() => _PunteggiScreenState();
}

class _PunteggiScreenState extends State<PunteggiScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      // appBar: appBarPunteggi(theme),
      appBar: const AppBarWidget('I tuoi punteggi'),
      body: BlocProvider(
          create: (context) => PunteggiBloc()..add(PunteggiLoadingEvent()),
          child: BlocBuilder<PunteggiBloc, PunteggiState>(
            builder: (context, state) {
              if (state is PunteggiLoading) {
                return const Center(child: LoadingWidget(80.0));
              } else if (state is PunteggiLoaded) {
                if (state.listCat.isEmpty) {
                  return Center(
                    child: Text(
                      'Non hai ancora votato nessun gatto!',
                      style: theme.textTheme.bodyMedium,
                    ),
                  );
                } else {
                  return listView(state.listCat, theme);
                }
              } else {
                return Container();
                // return GestureDetector(
                //   onTap: () {
                //     BlocProvider.of<PunteggiBloc>(context).add(PunteggiLoadingEvent());
                //   },
                //   child: Container(
                //     child: Center(child: Text('load')),
                //   ),
                // );
              }
            },
          )),
    );
  }

  Widget listView(list, ThemeData theme) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildImage(context, list, index),
                ),
                Expanded(
                  flex: 3,
                  child: buildDetails(list, index, theme),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildDetails(list, int index, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                list[index].razza!,
                style: theme.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 35,
                color: Color.fromARGB(255, 248, 140, 45),
              ),
              const SizedBox(width: 5),
              Text(list[index].punteggioUser!.toString(),
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(width: 20),
              InkWell(
                  onTap: (() async {
                    return showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36)),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetWidget(list[index], list);
                      },
                    );
                  }),
                  child: Text('Modifica voto',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context, list, int index) {
    var theme = Theme.of(context);
    var isThemeLight =
        MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? true
            : false;

    return InkWell(
      onTap: () {
        // catController.setCatSelect(list[index]);
        // Get.to(const CatDetailsScreen());
      },
      child: Container(
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              gradient: isThemeLight
                  ? LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: const [0.1, 0.6, 0.9],
                      colors: [
                        Colors.grey.shade400,
                        Colors.grey.shade300,
                        Colors.grey.shade200
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: const [0.1, 0.6, 0.9],
                      colors: [
                        Colors.black,
                        Colors.grey.shade900,
                        Colors.grey.shade800
                      ],
                    )),
          width: 130,
          height: 180,
          child: ImageWidget(list[index]),
        ),
      ),
    );
  }

  AppBar appBarPunteggi(ThemeData theme) {
    return AppBar(
      leading: GestureDetector(
          onTap: (() {
            Get.back();
          }),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: theme.secondaryHeaderColor,
          )),
      // backgroundColor: theme.backgroundColor,
      title: Text(
        'I tuoi punteggi',
        style:
            theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget(
    this.cat,
    this.list, {
    Key? key,
  }) : super(key: key);

  final Cats cat;
  final List<Cats> list;

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
                BlocProvider.of<PunteggiBloc>(context)
                    .add(AggiornaPunteggiEvent(list, cat, ratingUpdate));
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
