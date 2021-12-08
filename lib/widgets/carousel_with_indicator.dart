import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:evds_staff/widgets/carousel_item.dart';
import 'package:evds_staff/widgets/gallery_photo_view_wrapper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String> itemList;
  const CarouselWithIndicator({Key? key, required this.itemList})
      : super(key: key);

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: _createCarouselItems(widget.itemList),
              carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.3,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: () {
                  _carouselController.previousPage();
                },
                icon: const Icon(
                  CommunityMaterialIcons.chevron_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: () {
                  _carouselController.nextPage();
                },
                icon: const Icon(
                  CommunityMaterialIcons.chevron_right,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  open(context, _current, widget.itemList);
                },
                icon: const Icon(
                  CommunityMaterialIcons.fullscreen,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.itemList.map(
            (url) {
              int index = widget.itemList.indexOf(url);
              return Container(
                width: 12.0,
                height: 8.0,
                margin: const EdgeInsets.fromLTRB(2, 15, 2, 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade700,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  _createCarouselItems(List<String> carouselListItems) {
    return carouselListItems
        .map(
          (imageUrl) => Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        )
        .toList();
  }

  void open(BuildContext context, final int index, List<String> itemList) {
    Get.to(
      () => GalleryPhotoViewWrapper(
        galleryItems: itemList
            .asMap()
            .entries
            .map((entry) =>
                CarouselItem(id: entry.key.toString(), resource: entry.value))
            .toList(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
