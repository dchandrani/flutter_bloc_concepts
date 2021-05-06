import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        final notificationSnackBar = SnackBar(
          content: Text(
            'App ' +
                state.appNotifications.toString().toUpperCase() +
                ', Email ' +
                state.emailNotifications.toString().toUpperCase(),
          ),
          duration: Duration(
            milliseconds: 700,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
      },
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                SwitchListTile(
                  value: state.appNotifications,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleAppNotifications(newValue);
                  },
                  title: Text('App Notifications'),
                ),
                SwitchListTile(
                  value: state.emailNotifications,
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleEmailNotifications(newValue);
                  },
                  title: Text('Email Notifications'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
