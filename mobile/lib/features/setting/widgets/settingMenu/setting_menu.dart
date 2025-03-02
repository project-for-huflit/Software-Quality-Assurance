import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  final IconData icon;
  
  final String title, subTitle;
  
  final Widget? trailing;
  
  final VoidCallback? onTap;

  const SettingMenu({ 
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap
  });

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.amber),
      title: Text(title, style: Theme.of(context).textTheme.labelMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}