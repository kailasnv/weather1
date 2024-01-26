import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather1/presentation/bloc/weather_bloc.dart';
import 'package:weather1/presentation/widgets/blur_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// some dummy data
  final List<dynamic> gridData = const [
    [Icons.sunny, "Sunrise    ", "06:00"],
    [Icons.dark_mode_outlined, "Sunset    ", "18:30"],
    [Icons.fireplace_outlined, "Max Temp", "35 c"],
    [Icons.ice_skating_outlined, "Min Temp", "21 c"],
  ];

  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
    super.initState();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Weather1 ☁",
                        style: TextStyle(color: Colors.grey),
                      ),
                      // refresh
                      IconButton(
                          onPressed: () => BlocProvider.of<WeatherBloc>(context)
                              .add(FetchWeather()),
                          icon: const Icon(Icons.refresh_rounded)),
                    ],
                  ),

                  // 1st section
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 15),
                    child: Container(
                      height: 430,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      //  color: Colors.white.withOpacity(0.0),
                      // decoration: blackShadowDecoration(),
                      child: BlocBuilder<WeatherBloc, WeatherState>(
                        builder: (context, state) {
                          //when state is loading
                          if (state.isLoading) {
                            return const Center(
                              child: Column(
                                children: [
                                  Spacer(),
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  Text("Loading..."),
                                ],
                              ),
                            );
                          }
                          // if state has actual data
                          if (state.weather != null) {
                            return Column(
                              children: [
                                // Date // TODO: might use intl for date format
                                Text(
                                  state.weather!.date
                                      .toString()
                                      .split(" ")
                                      .first,
                                  style: const TextStyle(color: Colors.grey),
                                ),

                                //show - weather Image
                                Expanded(
                                  child: SizedBox(
                                    child: Center(
                                      // image
                                      child: Image.asset(state.weatherImage!),
                                    ),
                                  ),
                                ),

                                // celsius value
                                Text(
                                  state.weather!.temperature.toString(),
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                // weather condition name
                                Text(
                                  state.weather!.weatherMain ?? "Unknown",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),

                                // current location place
                                Text(
                                  " ${state.weather!.areaName} - ${state.weather!.country ?? ''}  ",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            );
                          } else {
                            // if no weather data
                            return const Center(
                              child: Text("Sorry! No data has found."),
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  // 2nd secion
                  // otColor.fromARGB(255, 107, 100, 100)nal values
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
                        // the item-tile
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
                                    // the grid-values
                                    BlocBuilder<WeatherBloc, WeatherState>(
                                      builder: (context, state) {
                                        const style =
                                            TextStyle(color: Colors.grey);

                                        if (state.weather != null) {
                                          if (index == 0) {
                                            return Text(
                                                state.weather!.sunrise
                                                    .toString()
                                                    .split(" ")
                                                    .last,
                                                style: style);
                                          } else if (index == 1) {
                                            return Text(
                                                state.weather!.sunset
                                                    .toString()
                                                    .split(" ")
                                                    .last,
                                                style: style);
                                          } else if (index == 2) {
                                            return Text(
                                                '${state.weather!.tempMax.toString().split(" ").first} c',
                                                style: style);
                                          } else {
                                            return Text(
                                                '${state.weather!.tempMin.toString().split(" ").first} c',
                                                style: style);
                                          }
                                        } else {
                                          return const Text("--", style: style);
                                        }
                                      },
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
