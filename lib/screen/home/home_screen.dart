// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguide/bloc/home_bloc/home_bloc.dart';
import 'package:petsguide/bloc/home_bloc/home_event.dart';
import 'package:petsguide/bloc/home_bloc/home_state.dart';
import 'package:petsguide/model/cat_model.dart';
import 'package:petsguide/screen/details/cat_details_screen.dart';
import 'package:petsguide/screen/home/widget/carousel_widget.dart';
import 'package:petsguide/screen/widget/build_cat_widget.dart';
import 'package:petsguide/screen/widget/loading_widget.dart';
import 'widget/app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.functionProva});
  final functionProva;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    openDrawerFunction() {
      // _scaffoldKey.currentState!.openEndDrawer();
    }

    return Scaffold(
        // key: _scaffoldKey,
        // endDrawer: const DrawerWidget(),
        body: BlocProvider(
          create: (context) => HomeBloc()..add(LoadAllCats()),
          child: CustomScrollView(
            slivers: [
              AppBarWidget(function: () {
                // openDrawerFunction();
                functionProva();
              }),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is LoadAllCatsState) {
                    return sliver_list_widget(state, theme);
                  } else {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(child: LoadingWidget(100.0)),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }

  SliverList sliver_list_widget(LoadAllCatsState state, ThemeData theme) {
    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 20),
        CarouselWidget(state.catsCarousel),
        titleWidget(theme, 'Mantello', 'Pelo corto'),
        const SizedBox(height: 20),
        SizedBox(
          height: 275,
          child: buildListView(state.catsPeloCorto, theme),
        ),
        const SizedBox(height: 10),
        titleWidget(theme, 'Mantello', 'Pelo medio'),
        const SizedBox(height: 10),
        SizedBox(
          height: 275,
          child: buildListView(state.catsPeloMedio, theme),
        ),
        const SizedBox(height: 10),
        titleWidget(theme, 'Mantello', 'Pelo lungo'),
        const SizedBox(height: 10),
        SizedBox(
          height: 275,
          child: buildListView(state.catsPeloLungo, theme),
        ),
      ]),
    );
  }

  Widget titleWidget(ThemeData theme, categoria, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            categoria,
            style: theme.textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade600,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: theme.secondaryHeaderColor),
            ),
          ),
          Text(value,
              style: theme.textTheme.labelMedium!.copyWith(
                  color: theme.primaryColor, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget buildListView(List<Cats> list, ThemeData theme) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if(state is LoadCatDetailsState) {
          // print(state.cat);
          // context.go('/login');
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatDetailsScreen()));
        }
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // BlocProvider.of<HomeBloc>(context).add(SetCatEvent(list[index]));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatDetailsScreen(list[index])));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: BuildCatWidget(list[index])
            )
          );
        }),
    );
  }
}
