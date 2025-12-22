import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboarding_viewmodel.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AppFlowViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Location")),
      body: Center(
        child: ElevatedButton(
          onPressed: vm.goToHome,
          child: const Text("Allow Location"),
        ),
      ),
    );
  }
}
