import 'package:flutter/material.dart';

import '../../res/sizes.dart';

class ProfileScreen extends StatefulWidget {
  static const ROUTE_NAME = '/profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 200),
              pinned: true,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  leading: CircleAvatar(
                    maxRadius: Sizes.SIZE_30,
                    backgroundImage: NetworkImage(
                        'data:image/png;base64,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'),
                  ),
                  title: Text("Index: $index"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "MySliverAppBar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
