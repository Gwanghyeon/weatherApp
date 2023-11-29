import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:weather_app/const/constants.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/pages/setting_page.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/widgets/error_dialog.dart';

part '../.generated/pages/home_page.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  late WeatherProvider weatherProvider;

  @override
  void initState() {
    super.initState();
    weatherProvider = context.read<WeatherProvider>();
    weatherProvider.addListener(_weatherProviderListener);
  }

  @override
  void dispose() {
    weatherProvider.removeListener(_weatherProviderListener);
    super.dispose();
  }

  void _weatherProviderListener() {
    final weatherState = context.read<WeatherProvider>().state;

    if (weatherState.status == WeatherStatus.error) {
      errorDialog(context, weatherState.customError.errMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          // To the Search Page
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              // 검색결과를 받아올 수 있도록 async 선언
              _city = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
              if (_city != null) {
                context.read<WeatherProvider>().fetchWeather(_city!);
              }
            },
          ),
          // To the Settings Page
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ));
            },
          ),
        ],
      ),
      body: Center(
        child: ShowWeather(), // showWeather function
      ),
    );
  }
}

@swidget
// Body: 도시이름, 온도, 그래픽 표현
Widget showWeather(BuildContext context) {
  final state = context.watch<WeatherProvider>().state;
  // 온도 표시 with ℃
  String _showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsProvider>().state.tempUnit;

    // 화씨 온도 표시
    if (tempUnit == TempUnit.fahrenheit) {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
    }

    // control + command + space for imoji
    return temperature.toStringAsFixed(2) + '℃';
  }

  // 온도 아이콘 표시 from network
  Widget _showWeatherIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'asset/images/loading.gif',
      image: 'http://$cIconHost/img/wn/$icon@4x.png',
      width: 90,
      height: 90,
    );
  }

  // Formatting weather description with recase packge
  Widget _formatText(String desc) {
    final formattedString = desc.titleCase;
    return Text(
      formattedString,
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  if (state.status == WeatherStatus.initial ||
      state.status == WeatherStatus.error) {
    return Center(
      child: Text('Select a city'),
    );
  } else if (state.status == WeatherStatus.loading) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Spacer(),
      // 도시 이름
      Text(
        state.weather.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      // 기준 시간
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              // TimeOfDay->format: returning localized time format
              TimeOfDay.fromDateTime(state.weather.lasteUpdated)
                  .format(context)),
          const SizedBox(width: 9),
          Text('(${state.weather.country})')
        ],
      ),
      // 온도
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _showTemperature(state.weather.temp),
          ),
          SizedBox(width: 15),
          Column(
            children: [
              Text(_showTemperature(state.weather.tempMax)),
              Text(_showTemperature(state.weather.tempMin)),
            ],
          )
        ],
      ),
      // Display weather with graphics
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            _showWeatherIcon(state.weather.icon),
            Expanded(child: _formatText(state.weather.description)),
            Spacer(),
          ],
        ),
      ),
      Spacer()
    ],
  );
}
