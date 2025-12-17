import 'package:flutter/material.dart';
import '../../widgets/hero_banner.dart';
import '../../widgets/section_header.dart';
import '../../widgets/horizontal_product_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeroBanner(),
            SizedBox(height: 20),

            SectionHeader(
              title: "New",
              subtitle: "You've never seen it before!",
            ),
            HorizontalProductList(isNew: true),

            SizedBox(height: 20),

            SectionHeader(title: "Sale", subtitle: "Super summer sale"),
            HorizontalProductList(isNew: false),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
