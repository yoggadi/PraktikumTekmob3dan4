import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Yoga Adi Pamungkas';
  String email = 'yogaadi@gmail.com';
  String bio = 'Praktikum Teknologi Mobile';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Yoga Adi Pamungkas';
      bio = prefs.getString('bio') ?? 'Praktikum Teknologi Mobile';
    });
  }

  void _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('bio', bio);
  }

  void updateProfile(String newName, String newBio) {
    setState(() {
      name = newName;
      bio = newBio;
    });
    _saveProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Foto Profil Ditekan!')),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/profile.png'),
              ),
            ),
            const SizedBox(height: 20),
            ProfileInfoItem(label: 'Nama', value: name),
            ProfileInfoItem(label: 'Email', value: email),
            ProfileInfoItem(label: 'Bio', value: bio),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/edit',
                  arguments: {'name': name, 'bio': bio},
                );

                if (result != null && result is Map<String, String>) {
                  updateProfile(result['name']!, result['bio']!);
                }
              },
              child: const Text('Edit Profil'),
            )
          ],
        ),
      ),
    );
  }
}