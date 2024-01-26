part of 'weather_bloc.dart';

class WeatherState {
  final bool isLoading;
  final Weather? weather;
  String? weatherImage;

  WeatherState({
    required this.isLoading,
    this.weather,
    this.weatherImage,
  });
}

final class WeatherInitial extends WeatherState {
  WeatherInitial({required super.isLoading});
}
