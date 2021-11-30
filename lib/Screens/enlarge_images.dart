import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EnlargeImages extends StatefulWidget {
  final List enlargeImages;

  EnlargeImages({Key? key, required this.enlargeImages}) : super(key: key);

  @override
  _EnlargeImagesState createState() => _EnlargeImagesState();
}

class _EnlargeImagesState extends State<EnlargeImages> {
  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  previous();
                },
                icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height,
                child: CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: widget.enlargeImages.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = widget.enlargeImages[index];
                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(
                    initialPage: 0,
                    height: MediaQuery.of(context).size.height,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),

                ),
              ),
              IconButton(
                onPressed: () {
                  next();
                },
                icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.clear,color: Colors.white,),
                )),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey,
        child: CachedNetworkImage(
          imageUrl: urlImage,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );

  next() => controller.nextPage();

  previous() => controller.previousPage();
}
