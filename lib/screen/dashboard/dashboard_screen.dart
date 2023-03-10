import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petsguide/screen/drawer/drawer_widget.dart';
import 'package:petsguide/screen/home/home_screen.dart';
import 'package:petsguide/screen/preferiti/preferiti_screen.dart';
import 'package:petsguide/screen/punteggi/punteggi_screen.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;  
  late Animation<double> _scaleAnimation;  

    

  openAndCloseDrawer() {
    // isOpen = !isOpen;
    setState(() {
      isOpen = !isOpen;
    });
    if(isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  navigateToPreferiti() {
    setState(() {
      isOpen = !isOpen;
    });
    if(isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreferitiScreen()));
  }

  navigateToPunteggi() {
    setState(() {
      isOpen = !isOpen;
    });
    if(isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PunteggiScreen()));
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
    ..addListener(() {
      setState(() {   
      });
    });
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: isOpen? 0 : -230,
            width: 230,
            curve: Curves.fastOutSlowIn,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {
                if(isOpen) {
                  openAndCloseDrawer();
                }
              },
              child: DrawerWidget(
                functionOpenClose: () {
                  openAndCloseDrawer();
                },
                functionNavigatePreferiti: () {
                  navigateToPreferiti();
                },
                functionNavigatePunteggi: () {
                  navigateToPunteggi();
                },
              ),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value - 30 * _animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(_animation.value * 200, 0),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: GestureDetector(
                    onTap: () {
                      // if(isOpen) {
                      //   openAndCloseDrawer();
                      // }
                    },
                    child: HomeScreen(
                      functionProva: () {
                        openAndCloseDrawer();
                      }
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}