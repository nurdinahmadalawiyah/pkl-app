import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';

class PembimbingDashboardPage extends StatelessWidget {
  const PembimbingDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'PKL ',
              style: kSemiBold.copyWith(
                color: primaryColor,
                fontSize: 24,
              ),
            ),
            Text(
              'TEDC',
              style: kSemiBold.copyWith(
                color: blackColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: greyColor,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: blackColor,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  trailing: const Icon(
                    IconlyBold.user_2,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Profile',
                    style: kMedium.copyWith(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () {},
                  trailing: const Icon(
                    IconlyBold.logout,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Logout',
                    style: kMedium.copyWith(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Kelola Nilai PKL',
                          style: kSemiBold.copyWith(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            IconlyBold.editSquare,
                            color: backgroundColor,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MenuDashboardPembimbing()
        ],
      ),
    );
  }
}

class MenuDashboardPembimbing extends StatelessWidget {
  const MenuDashboardPembimbing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const Expanded(
        child: GridMenu(),
      ),
    );
  }
}

class GridMenu extends StatelessWidget {
  const GridMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 6 / 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () {},
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    IconlyBold.document,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Biodata Industri',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    IconlyBold.activity,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Jurnal Kegiatan',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    IconlyBold.paper,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Daftar Hadir',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
       ],
    );
  }
}
