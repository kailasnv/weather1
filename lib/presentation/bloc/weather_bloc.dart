import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';
import 'package:weather1/domain/repository/repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial(isLoading: false)) {
    //
    on<FetchWeather>((event, emit) async {
      print("Fetching weather from internet.....");

      emit(WeatherState(isLoading: true)); // show loading..
      // get location of device
      final position = await WeatherRepository.determinePosition();
      // now fetch data from open-weather api
      final weatherData = await WeatherRepository.fetchWeatherApi(
        position.latitude,
        position.longitude,
      );

      emit(WeatherState(isLoading: false, weather: weatherData));
      print("lat : ${position.latitude} | lon : ${position.longitude}");
      print("weather data: ${weatherData.areaName}");

      // checking the weather condition code & setting selecting image
      if (state.weather != null) {
        switch (state.weather!.weatherConditionCode!) {
          case >= 200 && < 233:
            state.weatherImage = "assets/thundercloud.png";
          case >= 300 && < 322: // drizzle
            state.weatherImage = "assets/rain.png";
          case >= 500 && < 532:
            state.weatherImage = "assets/rain.png";
          case >= 600 && < 700:
            state.weatherImage = "assets/snow.png";
          case >= 700 && <= 800:
            state.weatherImage = "assets/clear.png";
          case >= 801 && < 805:
            state.weatherImage = "assets/cloudy.png";

            break;
          default:
            state.weatherImage = "assets/sunny.png";
        }
      }
    });
  }
}
