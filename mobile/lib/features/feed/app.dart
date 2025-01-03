import 'package:flutter/material.dart';

import '/animations.dart';
import '/features/app/models/user_model.dart';
import '/features/app/widgets/customs/animated_floating_action_button.dart';
import '/features/app/widgets/navigation/disappearing_bottom_navigation_bar.dart';
import '/features/app/widgets/navigation/disappearing_navigation_rail.dart';

class Feed extends StatefulWidget {
  const Feed({
    super.key,
    required this.currentUser,
  });

  final User currentUser;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
      _colorScheme.primary.withOpacity(0.14), _colorScheme.surface);

  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: 0,
      vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  int selectedIndex = 0;

  // bool wideScreen = false;
  bool controllerInitialized = false;

  /// @LOQ-burh
  /// breakpoint when w > 600
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    // wideScreen = width > 600;

    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
        child: Text(
      'Index 0: One',
      style: optionStyle,
    )),
    Text(
      'Index 1: Two',
      style: optionStyle,
    ),
    Text(
      'Index 2: Three',
      style: optionStyle,
    ),
    Text(
      'Index 4: Four',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Row(
            children: [
              DisappearingNavigationRail(
                railAnimation: _railAnimation,
                railFabAnimation: _railFabAnimation,
                selectedIndex: selectedIndex,
                backgroundColor: _backgroundColor,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              _widgetOptions.elementAt(selectedIndex),
              // Expanded(
              //   child: Container(
              //     color: _backgroundColor,
              //     child: ListDetailTransition(
              //       animation: _railAnimation,
              //       one: EmailListView(
              //         selectedIndex: selectedIndex,
              //         onSelected: (index) {
              //           setState(() {
              //             selectedIndex = index;
              //           });
              //         },
              //         currentUser: widget.currentUser,
              //       ),
              //       two: const ReplyListView(),
              //     ),
              //   ),
              // ),
            ],
          ),
          floatingActionButton: AnimatedFloatingActionButton(
            animation: _barAnimation,
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: DisappearingBottomNavigationBar(
            barAnimation: _barAnimation,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              _onItemTapped(index);
            },
          ),
        );
      },
    );
  }
}
