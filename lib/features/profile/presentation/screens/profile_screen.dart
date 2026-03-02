import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../data/datasources/remote/profile_remote_datasource.dart';
import '../../domain/entities/profile_entity.dart';
import '../../../order/presentation/viewmodel/order_viewmodel.dart';

final profileProvider = FutureProvider<ProfileEntity>((ref) async {
  final remote = ref.read(profileRemoteDatasourceProvider);
  final apiModel = await remote.getProfile();
  return apiModel.toEntity();
});

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _uploading = false;

  Future<void> _pickAndUploadImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked == null) return;

    setState(() => _uploading = true);

    try {
      final remote = ref.read(profileRemoteDatasourceProvider);
      await remote.uploadProfileImage(File(picked.path));

      // Refresh profile after upload
      ref.invalidate(profileProvider);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (profile) {
          final imageUrl = profile.profileImage != null
              ? '${ApiEndpoints.baseUrl.replaceAll('/api', '')}${profile.profileImage}'
              : null;

          final orderState = ref.watch(orderViewModelProvider);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PROFILE IMAGE
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                      Positioned(
                        child: InkWell(
                          onTap: _uploading ? null : _pickAndUploadImage,
                          child: CircleAvatar(
                            radius: 18,
                            child: _uploading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.camera_alt, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// NAME
                Center(
                  child: Text(
                    profile.fullName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                /// EMAIL
                Center(
                  child: Text(
                    profile.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 30),

                /// ORDERS TITLE
                const Text(
                  "My Orders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                /// ORDERS LIST
                if (orderState.loading)
                  const Center(child: CircularProgressIndicator())
                else if (orderState.orders.isEmpty)
                  const Text("No orders yet")
                else
                  Column(
                    children: orderState.orders.map((order) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: Text(
                            "Rs ${order.totalAmount.toStringAsFixed(2)}",
                          ),
                          subtitle: Text(order.createdAt.toString()),
                        ),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 20),

                /// LOGOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _logout,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _logout() async {
    try {
      // clear token from storage
      final remote = ref.read(profileRemoteDatasourceProvider);
      await remote.logout();

      if (!mounted) return;

      // navigate to login and remove all routes
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Logout failed: $e")));
    }
  }
}
