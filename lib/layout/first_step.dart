import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/first_step_controller.dart';
import '../routes/app_routes.dart';

class FirstStep extends StatelessWidget {
  final FirstStepController controller = Get.put(FirstStepController());

  FirstStep({super.key}) {
    // Get user data passed from registration
    final Map<String, dynamic>? userData = Get.arguments;
    if (userData != null) {
      controller.setUserName(userData['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A459F),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '"Diabetes Virtual Assistant"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Halo Divister! kenalan dulu yuk, namaku Davi, virtual assistant yang akan menemani kamu menjelajah aplikasi ini, gimana udah ga sabar kan?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Image.asset(
              'assets/davi.png',
              width: 200,
              height: 200,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Obx(() => Text(
                        'Hai, ${controller.userName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(height: 8),
                  const Text(
                    'kenalan dengan Davi yuk!',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.second_step);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A459F),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ayo Kenalan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
