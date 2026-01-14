import 'package:flutter/material.dart';
import 'package:quanlychitieu/pages/profile_page/widgets/setting_items.dart';
import 'package:quanlychitieu/utils/app_colors.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';
import 'package:quanlychitieu/utils/app_gardients.dart';
import 'package:quanlychitieu/utils/app_icons.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  final settingsGroups = AppSettingData.settingsGroups;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.backgroundMain,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          /// 🔹 HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              border: Border(
                bottom: BorderSide(color: AppColors.greyLight),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Profile', style: AppFonts.beVietnamBold20),
                const SizedBox(height: 4),
                Text(
                  'Manage your account and preferences',
                  style: AppFonts.beVietnamRegular14
                      .copyWith(color: AppColors.greyDark),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          //Profile Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppGradients.box,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 12,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white.withOpacity(0.3),
                      width: 4,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      AppIcons.person,
                      size: 36,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: AppFonts.beVietnamBold18
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@example.com',
                      style: AppFonts.beVietnamRegular14
                          .copyWith(color: AppColors.white.withOpacity(0.8)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: AppFonts.beVietnamMedium14
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          //Setting Group
          ...settingsGroups.map((group) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group['title'] as String,
                    style: AppFonts.beVietnamMedium14
                        .copyWith(color: AppColors.greyDark),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.greyVeryLight),
                    ),
                    child: Column(
                      children: (group['items'] as List<SettingItem>)
                          .asMap()
                          .entries
                          .map((entry) {
                        final item = entry.value;
                        return InkWell(
                          onTap: item.onTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              border: entry.key !=
                                  (group['items'] as List).length - 1
                                  ? const Border(
                                  bottom: BorderSide(
                                      color: AppColors.greyVeryLight))
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: item.danger
                                        ? AppColors.pinkVeryLight
                                        : AppColors.greyVeryLight,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    item.icon,
                                    color: item.danger
                                        ? AppColors.error
                                        : AppColors.greyDarkest,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: AppFonts.beVietnamMedium16.copyWith(
                                      color: item.danger
                                          ? AppColors.error
                                          : AppColors.greyDarkest,
                                    ),
                                  ),
                                ),
                                if (item.value != null)
                                  Text(
                                    item.value!,
                                    style: AppFonts.beVietnamRegular14
                                        .copyWith(color: AppColors.greyDark),
                                  ),
                                const SizedBox(width: 4),
                                const Icon(
                                  AppIcons.arrowForward,
                                  color: AppColors.grey,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          /// 🔹 LOGOUT
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.greyVeryLight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(AppIcons.logout, color: AppColors.error),
                const SizedBox(width: 8),
                Text(
                  'Logout',
                  style: AppFonts.beVietnamSemiBold16
                      .copyWith(color: AppColors.error),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// 🔹 FOOTER
          Column(
            children: [
              Text(
                'Made with ❤️ for better financial management',
                style: AppFonts.beVietnamRegular12
                    .copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                '© 2024 Finance Tracker',
                style: AppFonts.beVietnamRegular12
                    .copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}