import 'package:flutter/material.dart';
import 'package:weather1/presentation/widgets/blur_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

// some dummy data
  final List<dynamic> gridData = const [
    [Icons.sunny, "Sunrise    ", "06:00"],
    [Icons.dark_mode_outlined, "Sunset    ", "18:30"],
    [Icons.fireplace_outlined, "Max Temp", "35 c"],
    [Icons.ice_skating_outlined, "Min Temp", "21 c"],
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          padding: const EdgeInsets.all(15),
          child: BlurBackgroundWidget(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // app name
                  const Text(
                    "Weather1 ☁",
                    style: TextStyle(color: Colors.grey),
                  ),

                  // 1st section
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 15),
                    child: Container(
                      height: 430,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      //  color: Colors.white.withOpacity(0.0),
                      // decoration: blackShadowDecoration(),
                      child: const Column(
                        children: [
                          // Date
                          Text(
                            "January 7 2024",
                            style: TextStyle(color: Colors.grey),
                          ),

                          //show - weather Image
                          Expanded(
                            child: SizedBox(
                              child: Center(
                                // image
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            ),
                          ),

                          // celsius value
                          Text(
                            "21 C",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          // weather condition name
                          Text(
                            "CLOUDS",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                            ),
                          ),

                          // current location place
                          Text(
                            "Pullur-Irinjalakuda",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 2nd secion
                  // other additional values
                  Container(
                    height: 165,
                    // color: Colors.white.withOpacity(0.1),
                    decoration: blackShadowDecoration(),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 1,
                      ),
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // item tile
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // icon
                                Icon(gridData[index][0]),

                                // parameter name & value
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gridData[index][1],
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      gridData[index][2],
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration blackShadowDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 8,
          blurRadius: 8,
          offset: const Offset(0, 8),
        )
      ],
    );
  }
}
