import 'package:coffee_animation/coffee_challenge/model/coffee.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 500);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 0.35);

  final _textController = PageController();
  double? _currentPage = 0.0;
  double? _textPage = 0.0;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageController.page;
    });
  }

  void _textScrollListener() {
    setState(() {
      _textPage = _textController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_coffeeScrollListener);
    _textController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_coffeeScrollListener);
    _pageController.dispose();
    _textController.removeListener(_textScrollListener);
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
                left: 20,
                right: 20,
                bottom: -size.height * 0.22,
                height: size.height * 0.3,
                child: const DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.brown,
                        blurRadius: 90,
                        offset: Offset.zero,
                        spreadRadius: 45)
                  ]),
                )),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    if (value < coffees.length) {
                      _textController.animateToPage(value,
                          duration: _duration, curve: Curves.easeOut);
                    }
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: coffees.length+1 ,
                  itemBuilder: (context, index) {
                   if (index == 0) return const SizedBox.shrink();

                    final coffee = coffees[index-1 ];
                    final result = _currentPage! - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);
                    print("current page: $_currentPage");
                    print("current index: $index");
                    print("value: $value");
                    print("height down: ${size.height / 2.6 * (1 - value).abs()}");
                    print("opacity: $opacity");
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                                0.0, size.height / 2.6 * (1 - value).abs())
                            ..scale(value),
                          child: Opacity(
                              opacity: opacity,
                              child: Image.asset(
                                coffee.image,
                                fit: BoxFit.fitHeight,
                              ))),
                    );
                  }),
            ),
            if (_currentPage!.toInt() < 12)
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: 100,
                  child: Column(
                    children: [
                      Expanded(
                          child: PageView.builder(
                              controller: _textController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: coffees.length,
                              itemBuilder: (context, index) {
                                final opacity = (1 - (index - _textPage!).abs())
                                    .clamp(0.0, 1.0);

                                return Opacity(
                                    opacity: 1,
                                    child: Text(coffees[index].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                    ),

                                );
                              })),

                      AnimatedSwitcher(
                        duration: _duration,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: Text(
                          '\$ ${coffees[_currentPage!.toInt()].price.toStringAsFixed(2)}',
                          key: Key(coffees[_currentPage!.toInt()].name),
                          style: const TextStyle(fontSize: 40),
                        ),
                      )
                    ],
                  )),
          ],
        ));
  }
}
