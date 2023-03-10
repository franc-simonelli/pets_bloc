// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, sort_child_properties_last, unnecessary_new, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguide/bloc/details/bloc/details_bloc.dart';
import 'package:petsguide/bloc/tab_bloc/tab_bloc.dart';
import 'package:petsguide/bloc/tab_bloc/tab_event.dart';
import 'package:petsguide/bloc/tab_bloc/tab_state.dart';
import 'package:petsguide/screen/details/widget/information_cat_widget.dart';
import 'package:petsguide/screen/widget/cached_network_images.dart';
import 'package:petsguide/screen/widget/html_text.dart';

class CatDetailsScreen extends StatelessWidget {
  const CatDetailsScreen(this.cat, {super.key});

  final cat;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => TabBloc()..add(GetTabView()),
      child: Scaffold(
          body: CustomScrollView(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              slivers: [
            sliver_app_bar_widget(context, theme, cat),
            sliver_list_widget(context, theme, cat)
          ])),
    );
  }

  Widget sliver_list_widget(context, ThemeData theme, cat) {
    return SliverList(
      delegate: SliverChildListDelegate([
        BlocProvider(
          create: (context) => DetailsBloc()..add(GetCaratteristicheEvent(cat)),
          child: BlocBuilder<TabBloc, TabState>(
            builder: (context, state) {
              if (state is TabViewLoaded) {
                return Center(
                  child: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlText(cat.origine!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlText(cat.descrizione!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlText(cat.carattere!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlText(cat.salute!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlText(cat.alimentazione!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlText(cat.allevamento!),
                    ),
                    BlocBuilder<DetailsBloc, DetailsState>(
                      builder: (context, state) {
                        if (state is CatDetailsLoadedState) {
                          return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.caratteristiche.length,
                                  itemBuilder: ((context, index) {
                                    var caratteristica =
                                        state.caratteristiche[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(caratteristica.descrizione!,
                                              style: theme
                                                  .textTheme.labelMedium!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          SizedBox(width: 10),
                                          Row(
                                            children: [
                                              for (int i = 0; i < 5; i++)
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                      'contents/images/logo_zampa.png',
                                                      color: i <
                                                              caratteristica
                                                                  .punteggio!
                                                          ? theme.primaryColor
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  })));
                        } else {
                          return Container();
                        }
                      },
                    )
                  ][state.currentIndex],
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ]),
    );
  }

  SliverAppBar sliver_app_bar_widget(BuildContext context, ThemeData theme, cat) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      pinned: true,
      snap: false,
      stretch: true,
      expandedHeight: MediaQuery.of(context).size.width * 1.3,
      leading: Icon(
        Icons.arrow_back,
        color: Colors.transparent,
      ),
      flexibleSpace: flexibleWidget(theme, cat),
      bottom: bottomAppBarWidget(theme),
    );
  }

  PreferredSize bottomAppBarWidget(theme) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        color: theme.backgroundColor,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 60,
              child: BlocBuilder<TabBloc, TabState>(
                builder: (context, state) {
                  if (state is TabViewLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.tab.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              BlocProvider.of<TabBloc>(context)
                                  .add(TabChangeIndexEvent(index));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                color: Colors.transparent,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          state.tab[index].icon,
                                          color: state.currentIndex == index
                                              ? theme.primaryColor
                                              : theme.secondaryHeaderColor,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          state.tab[index].text!,
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                                  color: state.currentIndex ==
                                                          index
                                                      ? theme.primaryColor
                                                      : theme
                                                          .secondaryHeaderColor),
                                        )
                                      ],
                                    )),
                              ),
                            ));
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )),
      ),
    );
  }

  FlexibleSpaceBar flexibleWidget(ThemeData theme, cat) {
    return FlexibleSpaceBar(
        background: Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: theme.primaryColor.withOpacity(0.3),
          ),
          child: Stack(children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: CachedNetWorkImageWidget(cat.image!)),
            InformationCatWidget(cat)
          ]),
        ),
      ),
    ));
  }
}
