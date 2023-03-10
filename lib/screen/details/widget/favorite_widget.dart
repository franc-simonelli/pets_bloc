import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petsguide/bloc/preferiti_bloc/preferiti_bloc.dart';

import 'package:petsguide/screen/widget/loading_widget.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget(this.cat, {super.key});

  final cat;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: theme.primaryColor.withOpacity(0.8),
        ),
        child: BlocProvider(
          create: (context) =>
              PreferitiBloc()..add(CheckIsFavoriteEvent(widget.cat)),
          child: BlocBuilder<PreferitiBloc, PreferitiState>(
            builder: (context, state) {
              if (state is IsFavoriteState) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<PreferitiBloc>(context)
                        .add(RemoveFavorite(state.preferito));
                  },
                  child: const Icon(
                    FontAwesomeIcons.heartCircleCheck,
                    color: Colors.white,
                  ),
                );
              } else if (state is IsNotFavoriteState) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<PreferitiBloc>(context)
                        .add(AddFavorite(widget.cat));
                  },
                  child: const Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.white,
                  ),
                );
              } else {
                return const LoadingWidget(20.0);
              }
            },
          ),
        ));
  }
}
