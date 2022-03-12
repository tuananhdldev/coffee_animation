import 'dart:ui';

import 'package:coffee_animation/coffee_challenge/model/coffee.dart';
import 'package:coffee_animation/coffee_challenge/ui/widgets/coffee_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'coffee_list_page.dart';

enum SliderAction { Next, Previous, None }

class CoffeeHomePage extends StatelessWidget {
  const CoffeeHomePage({Key? key}) : super(key: key);

  void _openCoffeeListPage(BuildContext context, SliderAction sliderAction) {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: CoffeeListPage(
               initialAction: sliderAction
            ),);
            }));
  }

  void _onVerticalDragUpdate(BuildContext context, DragUpdateDetails details) {
    if (details.primaryDelta! > 2.0) {
      _openCoffeeListPage(context, SliderAction.Previous);

    }else if(details.primaryDelta!<-2){
      _openCoffeeListPage(context, SliderAction.Next);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient Background
          const DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0, -3),
                      colors: [Colors.brown, Colors.white]))),
          Column(
            children: [
              const CoffeeAppBar(
                brightness: Brightness.light,
              ),
              Expanded(child: LayoutBuilder(
                builder: (context, contraints) {
                  final height = contraints.maxHeight;
                  return GestureDetector(
                    onTap: ()=>_openCoffeeListPage(context, SliderAction.None),
                    onVerticalDragUpdate: (details)=>_onVerticalDragUpdate(context, details),
                    child: Stack(
                      children: [
                        _CoffeeTransformedItem(
                          displacement: 0,
                          scale: .4,
                          endTransitionOpacity: .5,
                          coffee: coffees[0],
                        ),
                        _CoffeeTransformedItem(
                          displacement: height * .1,
                          scale: 1.1,
                          endTransitionOpacity: .8,
                          coffee: coffees[1],
                        ),
                        _CoffeeTransformedItem(
                          displacement: height * .23,
                          scale: 1.45,
                          isOverflowed: true,
                          fixedScale: 1.2,
                          coffee: coffees[2],
                        ),
                        Align(
                          alignment: const Alignment(0, 0.3),
                          child: Text.rich(
                            TextSpan(
                              text: 'Fika',
                              children: [
                                TextSpan(
                                    text: '\nCoffee',
                                    style: GoogleFonts.poppins(
                                        height: 1.0, fontSize: 60))
                              ],
                              style: GoogleFonts.lilitaOne(
                                  fontSize: 70,
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        _CoffeeTransformedItem(
                            displacement: height * .75,
                            scale: 1.75,
                            fixedScale: 1.5,
                            isOverflowed: true,
                            coffee: coffees[3])
                      ],
                    ),
                  );
                },
              ))
            ],
          )
        ],
      ),
    );
  }
}

class _CoffeeTransformedItem extends StatelessWidget {
  const _CoffeeTransformedItem(
      {Key? key,
      required this.displacement,
      this.scale = 1.0,
      this.fixedScale,
      this.isOverflowed = false,
      this.endTransitionOpacity = 1.0,
      required this.coffee})
      : super(key: key);
  final double displacement;
  final double scale;
  final double? fixedScale;
  final bool isOverflowed;
  final double endTransitionOpacity;
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, displacement),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: AspectRatio(
          aspectRatio: 0.85,
          child: Hero(
            tag: coffee.name,
            flightShuttleBuilder: (_, animation, __, ___, ____) {
              return AnimatedBuilder(
                animation: animation,
                builder: (_, child) {
                  return Transform.scale(
                    scale: (isOverflowed
                        ? lerpDouble(fixedScale, 1.0, animation.value)!
                        : 1.0),
                    child: Opacity(
                      opacity: lerpDouble(
                          1.0, endTransitionOpacity, animation.value)!,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(coffee.image),
              );
            },
            child: Image.asset(coffee.image),
          ),
        ),
      ),
    );
  }
}
