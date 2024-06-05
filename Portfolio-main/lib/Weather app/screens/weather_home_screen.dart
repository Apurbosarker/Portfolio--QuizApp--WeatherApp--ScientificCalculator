import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Weather%20app/controller/global_controller.dart';
import 'package:portfolio/Weather%20app/utils/custom_colors.dart';
import 'package:portfolio/Weather%20app/widgets/comfort_level.dart';
import 'package:portfolio/Weather%20app/widgets/current_weather_widget.dart';
import 'package:portfolio/Weather%20app/widgets/daily_data_forecast.dart';
import 'package:portfolio/Weather%20app/widgets/header_widget.dart';
import 'package:portfolio/Weather%20app/widgets/hourly_data_widget.dart';


class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WeatherHomeScreen> {
  // call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/clouds.png",
                    height: 200,
                    width: 200,
                  ),
                  const CircularProgressIndicator()
                ],
              ))
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    // for our current temp ('current')
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather()),
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather())
                  ],
                ),
              )),
      ),
    );
  }
}
