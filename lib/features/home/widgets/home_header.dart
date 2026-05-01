import 'package:flutter/material.dart';
import 'address_selector.dart';
import 'profile_icons.dart';
import 'search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.32,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 73, 18),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 18),
              Row(
                children: [
                  Expanded(child: AddressSelector()),
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: ProfileIcons(),
                  ),
                ],
              ),
              SizedBox(height: 24),
              HomeSearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}
