import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../rating.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular packages",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "see all",
              style: TextStyle(
                color: Color.fromARGB(255, 3, 32, 86),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          height: 180,
          child: ListView.separated(
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemBuilder: (context, index) => Container(
              width: 335,
              height: 160,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 1, color: Color.fromARGB(255, 2, 9, 17)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    top: 16,
                    child: Container(
                      width: 101,
                      height: 128,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/place${index + 1}.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 137,
                    bottom: -30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Elegushi Beach',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 19.20,
                          ),
                        ),
                        SizedBox(width: 43),
                        Icon(CommunityMaterialIcons.heart_outline)
                      ],
                    ),
                  ),
                  const Positioned(
                    left: 137,
                    top: 55,
                    child: Text(
                      '\$745,00',
                      style: TextStyle(
                        color: Color(0xFFFF0000),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 137,
                    top: 83,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Rating(rating: 4.8, ratingCount: 12),
                        const SizedBox(width: 5),
                        const Text(
                          '4.8',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    left: 137,
                    top: 109,
                    child: Text(
                      'The resort is a place used for \n'
                      'vacation, relaxation or as a day ',
                      style: TextStyle(
                        color: Color(0xFF243757),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
