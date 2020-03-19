import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String> photos;
  CarouselWithIndicator(this.photos);
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      caroselWidget(),
      Positioned(bottom: 60, child: circleIndicator())
    ]);
  }

  Widget caroselWidget() {
    return CarouselSlider(
      items: widget.photos.map((item) {
        return Image.network(
          item,
          fit: BoxFit.cover,
        );
      }).toList(),
      viewportFraction: 1.0,
      height: Sizes.hightDetails + 30,
      autoPlay: false,
      enableInfiniteScroll: false,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );
  }

  Widget circleIndicator() {
    return Container(
      height: 20,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Container(
                width: _current == index ? 12 : 10,
                height: _current == index ? 12 : 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Coolor.WHITE
                        : Coolor.WHITE.withOpacity(0.5)),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                width: 5,
              );
            },
            itemCount: widget.photos.length),
      ),
    );
  }
}
