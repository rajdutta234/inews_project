import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/custom_app_bar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final box = GetStorage();
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  String name = 'John Doe';
  String email = 'john.doe@email.com';

  @override
  void initState() {
    super.initState();
    isDarkMode = box.read('isDarkMode') ?? false;
    notificationsEnabled = box.read('notificationsEnabled') ?? true;
    name = box.read('name') ?? 'John Doe';
    email = box.read('email') ?? 'john.doe@email.com';
  }

  void _editAccount() async {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final result = await Get.dialog(
      AlertDialog(
        title: const Text('Edit Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: null),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(
              result: {
                'name': nameController.text,
                'email': emailController.text,
              },
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() {
        name = result['name'];
        email = result['email'];
      });
      box.write('name', name);
      box.write('email', email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        showSearch: false,
        showBack: true,
        showSettings: false,
        onBack: () => Get.back(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Account',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(name),
            subtitle: Text(email),
            trailing: TextButton(
              onPressed: _editAccount,
              child: const Text('Edit'),
            ),
          ),
          const Divider(height: 32),
          const Text(
            'Preferences',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (val) {
              setState(() => isDarkMode = val);
              Get.changeTheme(val ? ThemeData.dark() : ThemeData.light());
              box.write('isDarkMode', val);
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() => notificationsEnabled = val);
              box.write('notificationsEnabled', val);
            },
            secondary: const Icon(Icons.notifications_active),
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('INEWS v1.0.0'),
          ),
        ],
      ),
    );
  }
}
