import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/discreiption_controller.dart';

class DiscreiptionView extends GetView<DiscreiptionController> {
  const DiscreiptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiscreiptionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DiscreiptionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
