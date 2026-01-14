import 'package:flutter/material.dart';
import 'package:quanlychitieu/utils/app_icons.dart';

class SettingItem {
  final IconData icon;
  final String label;
  final String? value;
  final bool danger;
  final VoidCallback onTap;

  const SettingItem({
    required this.icon,
    required this.label,
    this.value,
    this.danger = false,
    required this.onTap,
  });
}

class AppSettingData{
  static final settingsGroups = [
    {
      'title': 'Account',
      'items': [
        SettingItem(
          icon: AppIcons.person,
          label: 'Edit Profile',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.notifications,
          label: 'Notifications',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.settings,
          label: 'Privacy & Security',
          onTap: () {},
        ),
      ],
    },
    {
      'title': 'Preferences',
      'items': [
        SettingItem(
          icon: AppIcons.wallet,
          label: 'Currency',
          value: 'VND',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.explore,
          label: 'Language',
          value: 'English',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.dashboard,
          label: 'Theme',
          value: 'Light',
          onTap: () {},
        ),
      ],
    },
    {
      'title': 'Data',
      'items': [
        SettingItem(
          icon: AppIcons.download,
          label: 'Export Data',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.upload,
          label: 'Backup & Restore',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.delete,
          label: 'Reset Data',
          danger: true,
          onTap: () {},
        ),
      ],
    },
    {
      'title': 'About',
      'items': [
        SettingItem(
          icon: AppIcons.info,
          label: 'App Version',
          value: 'v1.0.0',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.settings,
          label: 'Terms of Service',
          onTap: () {},
        ),
        SettingItem(
          icon: AppIcons.settings,
          label: 'Privacy Policy',
          onTap: () {},
        ),
      ],
    },
  ];
}