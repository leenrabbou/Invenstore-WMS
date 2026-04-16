// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Screens/EditProfile.dart';
import 'package:project_1_v2/Services/Warehouse/ProfileService.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/helper/CustomListTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.isBar});
  final bool isBar;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      final locale = Provider.of<LocalizationProvider>(
        context,
        listen: false,
      ).language!;
      await Future.delayed(const Duration(seconds: 2));
      try {
        await ProfileServices().showProfileWarehouseService(locale);

        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S().myProfile,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        leading: widget.isBar
            ? null
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const EditProfileScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profile!.image != null
                      ? CircleAvatar(
                          backgroundImage: loadingImage,
                          // NetworkImage('$imageUrl/${profile!.image}'),
                          radius: 80,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.background,
                        )
                      : profile!.gender == 'male'
                      ? const CircleAvatar(
                          backgroundImage: AssetImage('images/male3.jpg'),
                          radius: 80,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage('images/female2.jpg'),
                          radius: 80,
                        ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile!.fullName,
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile!.role,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomListTile(
                icon: const Icon(Icons.person),
                text: profile!.userName,
                title: S().userName.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.email),
                text: profile!.email,
                title: S().email_Address.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.phone),
                text: profile!.phoneNumber,
                title: S().phoneNumber.toUpperCase(),
              ),
              CustomListTile(
                icon: profile!.gender == 'male'
                    ? const Icon(Icons.male)
                    : const Icon(Icons.female),
                text: profile!.gender,
                title: S().gender.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.calendar_month),
                text: profile!.birthDate,
                title: S().birthDay.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.numbers),
                text: profile!.ssn,
                title: S().ssn.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.location_city),
                text: profile!.city,
                title: S().city.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.location_history),
                text: profile!.state,
                title: S().state.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.location_on),
                text: profile!.address != null ? profile!.address! : '---',
                title: S().address.toUpperCase(),
              ),
              CustomListTile(
                icon: const Icon(Icons.work),
                text: profile!.employable,
                title: S().workplace.toUpperCase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
