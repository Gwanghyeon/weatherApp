import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/providers.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListTile(
          title: Text('Temperature Unit'),
          subtitle: Text('℃ / ℉'),
          trailing: Switch(
            value: context.watch<TempSettingsProvider>().state.tempUnit ==
                    TempUnit.celcius
                ? true
                : false,
            onChanged: (_) {
              context.read<TempSettingsProvider>().toggleTempUnit();
            },
          ),
        ),
      ),
    );
  }
}
