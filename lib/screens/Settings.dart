import 'package:cibu_app/screens/FirstScreen.dart';
import 'package:cibu_app/services/notifi_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../provider/auth_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(137, 146, 231, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          alignment: const Alignment(2.0, -0.5),
        ),
        toolbarHeight: 110,
        elevation: 0,
        flexibleSpace: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 240, 0),
          color: const Color.fromRGBO(137, 146, 231, 1),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Colors.white,
                      Color.fromRGBO(27, 237, 244, 1),
                    ],
                    begin: Alignment.bottomLeft,
                  ).createShader(bounds);
                },
                child: const Text(
                  'CIBU',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      height: 4),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 250),
            ElevatedButton(
                child: const Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  backgroundColor: const Color.fromRGBO(0, 162, 255, 1),
                ),
                onPressed: () async {
                  ap.userSignOut().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const FirstScreen(),
                          ),
                        ),
                      );
                }),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text("Informasi Akun Dibuat"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  backgroundColor: const Color.fromRGBO(0, 162, 255, 1),
                ),
                onPressed: () async {
                  NotificationService().showNotification(
                      title: 'Cibu App',
                      body:
                          'Akun kamu dibuat pada (Tanggal/Bulan/Tahun): ${ap.userModel.createdAt}-${ap.userModel.createdAtMonth}-${ap.userModel.createdAtYear}.');
                  final now = DateTime.now();
                  final createdAt = DateTime(
                      int.parse(ap.userModel.createdAtYear),
                      int.parse(ap.userModel.createdAtMonth),
                      int.parse(ap.userModel.createdAt),
                      0,
                      0,
                      0);

                  final ages = now.difference(createdAt).inDays;
                  final agess = (ages / 365).truncate();
                  final age = (ages - (365 * agess));

                  Future.delayed(const Duration(seconds: 8), () {
                    NotificationService().showNotification(
                      title: 'Cibu App',
                      body: 'Akun kamu sudah berusia $agess tahun $age hari.',
                    );
                  });
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
