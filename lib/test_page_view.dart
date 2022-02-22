import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'coffee.dart';

class TestPageView extends HookConsumerWidget {
  const TestPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = usePageController( viewportFraction: 0.35 );
    final _currentPage = useState(0.0);
    _controller.addListener(() {
      _currentPage.value = _controller.page!;
      // print("page: ${_controller.page}");
    });
    final size= MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [ PageView.builder(
          controller: _controller,
            scrollDirection: Axis.vertical,
            itemCount:  coffees.length+1,
            itemBuilder: (context, index){

if(index == 0) return const SizedBox.shrink();
              final item = coffees[index-1];
              final result= _currentPage.value- index+1;
              final value = -0.4 * result + 1;
print("index:$index");
              print(value);
          return Padding(
            padding: const EdgeInsets.only(  bottom: 40.0),
            child: Transform(
               alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(0.0,size.height/2.6*(1-value).abs() )
                  ..scale(value)
                ,
                child: Opacity(
                    opacity: value.clamp(0.0, 1),
                    child: Image.asset(item.image))),
          );
        }

        ),
  ]
      ),
    );
  }
}
