import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:ieltszone/pages/register_page.dart';
import 'package:ieltszone/services/storage_service.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Icon(
            CupertinoIcons.person_crop_circle_fill,
            size: 150,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Text(
            provider.user.fullName,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'ID: ${provider.user.id}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => logout(context),
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Edit'),
                ),
              ),
            ],
          )
          // SizedBox(height: 30),
        ],
      ),
    );
  }

  logout(BuildContext context) async {
    await UserStorage().removeUser();

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RegisterPage()), (route) => false);
  }
}
