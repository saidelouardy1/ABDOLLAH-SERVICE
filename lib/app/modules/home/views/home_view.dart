import 'package:abdollah_srevice/app/config/Assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 35, bottom: 30),
        color: Colors.white,
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  ////////////////////////////////// column two
                  child: Column(
                    children: [
                      //////////////////////////////// image with name
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png"),
                                  radius: 25,
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                right: -5,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: SvgPicture.asset(
                                    Images_Icon.pencil,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //////////////////////////// page view
                      SizedBox(height: 15),
                      SizedBox(
                        width: Get.width,
                        height: 180,
                        child: PageView.builder(
                            itemCount: homeController.image_PageViwe.length,
                            controller: homeController.pageController,
                            onPageChanged: (value) =>
                                homeController.currentIndex.value = value,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    elevation: 3,
                                    child: Container(
                                      width: Get.width,
                                      height: 170,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(homeController
                                                  .image_PageViwe[index]),
                                              fit: BoxFit.cover)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'hi',
                                          ),
                                          Text('hi')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          homeController.image_PageViwe.length,
                          (index) => Obx(() => Container(
                                width: 12,
                                height: 12,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color:
                                      homeController.currentIndex.value == index
                                          ? Colors.black
                                          : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
