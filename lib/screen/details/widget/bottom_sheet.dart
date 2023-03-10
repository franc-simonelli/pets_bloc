import 'package:flutter/material.dart';


class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: 220,
      
      child:Column(
        children: [
          const SizedBox(height: 20),
          Text('Vota questo micio!', style: theme.textTheme.displayMedium ),
          const SizedBox(height: 20),
          // RatingBar.builder(
          //   unratedColor: Colors.grey,
          //   itemSize: 40,
          //   initialRating: 1,
          //   minRating: 1,
          //   direction: Axis.horizontal,
          //   allowHalfRating: false,
          //   itemCount: 5,
          //   itemBuilder: (context, _) => const Icon(
          //     Icons.star,
          //     color: Color.fromARGB(255, 248, 140, 45),
          //   ),
          //   onRatingUpdate: (rating) {
          //     // catController.setRatingSelected(rating);
          //   },
          // ),
          const SizedBox(height: 40),
          
          GestureDetector(
            onTap: () async {
              // await catController.setPunteggio();
            },
            
              // return catController.loadingPunteggio.value
              // ?
              // const LoadingWidget(100.0)
              // :
              // Container(
              //   width: 150,
              //   height: 40,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     color: theme.primaryColor
              //   ),
              //   child: Center(child: Text('Conferma', style: theme.textTheme.labelLarge)),
              // );
            
          )
        ],
      )
    );
  }
}