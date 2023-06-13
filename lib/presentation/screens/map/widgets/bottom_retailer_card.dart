import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rate/rate.dart';
import 'package:sizer/sizer.dart';

import '../retailer_on_map_entity.dart';

class BottomRetailerCard extends StatefulWidget {
  const BottomRetailerCard({
    super.key,
    required this.list,
    required this.update,
    required this.onCardTap,
    required this.currentIndex,
    required this.carousalController,
  });

  final List<InternetSpeedOnMapEntity> list;
  final Function(int index) update;
  final Function(InternetSpeedOnMapEntity) onCardTap;
  final CarouselController carousalController;

  final int currentIndex;

  @override
  State<BottomRetailerCard> createState() => _BottomRetailerCardsState();
}

class _BottomRetailerCardsState extends State<BottomRetailerCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 170,
      child: CarouselSlider(
        carouselController: widget.carousalController,
        options: CarouselOptions(
          viewportFraction: 0.90,
          enableInfiniteScroll: false,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          aspectRatio: 2.0,
          autoPlayCurve: Curves.easeInCirc,
          enlargeCenterPage: true,
          onScrolled: (scrollValue) {
            if ((scrollValue! % 1) == 0) {
              setState(() {});
            }
          },
          onPageChanged: (index, reason) {
            widget.update(index);
          },
        ),
        items: widget.list.map(
          (entity) {
            // print("QWQW:: "+entity.toString());
            return GestureDetector(
              onTap: () {
                widget.onCardTap(entity);
              },
              onLongPress: () {
                debugPrint("SSS:$entity");
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: Border.all(
                    color: entity.isSelected!
                        ? Colors.blueAccent
                        : Colors.transparent,
                  ),
                ),
                child: Column(
                  children: [
                    _getContainer(
                      url: entity.typeOfConnection.toString() == "Wifi"
                          ? "https://img.freepik.com/free-icon/wifi_318-1573.jpg"
                          : "https://static.thenounproject.com/png/2811966-200.png",
                      name: entity.nameOfMobile.toString(),
                      typeOfConnection: entity.typeOfConnection!,
                      qualityOfYoutube:
                          entity.qualityOfYoutube!.round().toString(),
                      downloadSpeed: entity.downloadSpeed.toString(),
                      uploadSpeed: entity.uploadSpeed.toString(),
                      rate: entity.rate.toString(),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _getContainer({
    required String url,
    required String name,
    required String typeOfConnection,
    required String qualityOfYoutube,
    required String downloadSpeed,
    required String uploadSpeed,
    required String rate,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        bottom: 8,
        left: 16,
      ),
      child: Row(
        children: [
          const SizedBox(width: 4),
          getTypeConnectionIcon(url: url),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  "Device Name: $name",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  "Type of Connection: $typeOfConnection",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Download Speed: $downloadSpeed",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Upload Speed: $uploadSpeed",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              getSecondRow(
                qualityOfYoutube: qualityOfYoutube,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Text(
                    "Rate:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5,),
                  Rate(
                    iconSize: 18,
                    color: Colors.blueAccent,
                    allowHalf: false,
                    allowClear: true,
                    initialValue: double.parse(rate),
                    readOnly: true,
                    onChange: (value){
                      
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTypeConnectionIcon({required String url}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            url,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getSecondRow({
    required String qualityOfYoutube,
  }) {
    List<String> split = qualityOfYoutube.split('P');

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Quality Of Youtube: ",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "${split[0]} P",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
