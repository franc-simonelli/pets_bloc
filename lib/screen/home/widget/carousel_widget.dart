import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petsguide/model/cat_model.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget(this.catsCarousel, {super.key});
  final List<Cats> catsCarousel;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int currentIndex = 0;

  setIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1.5,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                scrollPhysics: BouncingScrollPhysics(),
                viewportFraction: 1.0,
                aspectRatio: 1.8,
                autoPlay: true,
                onPageChanged: ((index, reason) {
                  // carouselController.setCurrentIndex(index);
                  setIndex(index);
                })),
            items: widget.catsCarousel
              .map(
                (item) => GestureDetector(
                  onTap: () {
                
                  },
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                            ),
                          image: DecorationImage(
                            image: NetworkImage(item.imageCarousel!),
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ).toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: 10,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.catsCarousel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: currentIndex == index ? 20 : 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentIndex == index ? theme.primaryColor : theme.secondaryHeaderColor
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
