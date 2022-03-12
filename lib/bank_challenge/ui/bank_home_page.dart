import 'package:coffee_animation/bank_challenge/model/bank_models.dart';
import 'package:coffee_animation/bank_challenge/ui/widgets/header_home_page.dart';
import 'package:flutter/material.dart';

class BankHomePage extends StatefulWidget {
  const BankHomePage({Key? key}) : super(key: key);

  @override
  _BankHomePageState createState() => _BankHomePageState();
}

class _BankHomePageState extends State<BankHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PageController _pageController;
  late int _indexPage;
  late int _currentIndex;
  late bool _enableAddCreditCard;
  double _blueBgTranslatePercent = 1.0;
  double _blueBgTransitionPercent = 1.0;
  bool _hideByVelocity = false;

  late final BankClient currentUser;
  late final List<BankAccount> userAccounts;
  late AccountTransaction selectedLastTransaction;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .85, initialPage: 1)
      ..addListener(_pageListener);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _indexPage = 1;
    _currentIndex = 1;
    _enableAddCreditCard = false;

    currentUser = BankClient.currentUser;
    userAccounts = currentUser.accounts;
    selectedLastTransaction = userAccounts.first.lastTransaction;
    super.initState();
  }

  void _pageListener() {
    if (_pageController.page! > 1) {
      _blueBgTranslatePercent = _pageController.page!;
    } else {
      _blueBgTransitionPercent = _pageController.page!;
      _enableAddCreditCard = (_blueBgTransitionPercent < .1);
    }
    setState(() {});
  }

  void _onPageChange(int value) {
    _currentIndex = value;
    setState(() {
      _indexPage = (value == 0) ? 0 : value - 1;
      selectedLastTransaction = userAccounts[_indexPage].lastTransaction;
    });
  }

  //Custom transition builder for the bottom AnimatedSwitch
  Widget _transitionBuilder(child, animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(animation),
        child: child,
      ),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_currentIndex > 0) {
      if (details.primaryDelta! > 0.0) {
        _controller.value += 0.004;
      } else {
        _controller.value -= 0.04;
      }
      if (details.primaryDelta! > -1.5) {
        _hideByVelocity = false;
      } else {
        _hideByVelocity = true;
        _controller.reverse();
      }
    }
    setState(() {});
  }
  void _onVerticalDragEnd(DragEndDetails details){
    if(_currentIndex>=0)
      {
        if(_controller.value <0.2||_hideByVelocity){
          _controller.reverse();
        }else{
          _controller.forward();
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:  [
            HeaderHomePage(expandedFactor: 0.8,)
          ],
        ),
      ),
    );
  }
}
