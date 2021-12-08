import 'package:flutter/widgets.dart';

class CarouselItem {
  CarouselItem({
    required this.id,
    required this.resource,
  });

  final String id;
  final String resource;
}

class CarouselItemThumbnail extends StatelessWidget {
  const CarouselItemThumbnail({
    Key? key,
    required this.carouselItem,
    required this.onTap,
  }) : super(key: key);

  final CarouselItem carouselItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: carouselItem.id,
          child: Image.network(carouselItem.resource, height: 80.0),
        ),
      ),
    );
  }
}
