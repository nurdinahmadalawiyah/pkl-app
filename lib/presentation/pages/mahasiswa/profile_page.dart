import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/profile_model.dart';
import 'package:magang_app/presentation/cubit/profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: const BackButton(color: backgroundColor),
        title: Text(
          'Profile',
          style: kMedium.copyWith(color: backgroundColor),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<ProfileState>(
          stream: _profileCubit.stream,
          initialData: ProfileInitial(),
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return DataProfileMahasiswa(profile: profile);
            } else if (state is ProfileNoConnection) {
              return Center(
                child: Text(
                  'state.message',
                  style: kMedium.copyWith(color: blackColor, fontSize: 23),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: kMedium.copyWith(color: blackColor, fontSize: 23),
                ),
              );
            } else {
              return const Text('Unknown Error');
            }
          },
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 5, bottom: 20, left: 20, top: 20),
              child: ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/ganti-password'),
                style: ElevatedButton.styleFrom(
                  primary: tertiaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(15),
                ),
                icon: const Icon(
                  IconlyBold.password,
                  color: backgroundColor,
                ),
                label: FittedBox(
                  child: Text(
                    'Ganti Password',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: kSemiBold.copyWith(
                      fontSize: 16,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20, bottom: 20, left: 5, top: 20),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(15),
                ),
                icon: const Icon(
                  IconlyBold.editSquare,
                  color: backgroundColor,
                ),
                label: FittedBox(
                  child: Text(
                    'Edit Profile',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: kSemiBold.copyWith(
                      fontSize: 16,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataProfileMahasiswa extends StatelessWidget {
  const DataProfileMahasiswa({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderAndAvatar(),
        MainInformation(profile: profile),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Detail Informasi',
            style: kMedium.copyWith(
              fontSize: 16,
              color: blackColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DetailInformation(profile: profile)
      ],
    );
  }
}

class DetailInformation extends StatelessWidget {
  const DetailInformation({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: accentColor, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semester',
                    style: kMedium.copyWith(
                      fontSize: 13,
                      color: tertiaryColor,
                    ),
                  ),
                  Text(
                    profile.data.semester,
                    style: kMedium.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: kMedium.copyWith(
                      fontSize: 13,
                      color: tertiaryColor,
                    ),
                  ),
                  Text(
                    profile.data.email,
                    style: kMedium.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: kMedium.copyWith(
                      fontSize: 13,
                      color: tertiaryColor,
                    ),
                  ),
                  Text(
                    profile.data.username,
                    style: kMedium.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Hp',
                    style: kMedium.copyWith(
                      fontSize: 13,
                      color: tertiaryColor,
                    ),
                  ),
                  Text(
                    profile.data.nomorHp,
                    style: kMedium.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainInformation extends StatelessWidget {
  const MainInformation({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              profile.data.nama,
              style: kSemiBold.copyWith(
                fontSize: 24,
                color: blackColor,
              ),
            ),
            Text(
              profile.data.namaProdi,
              style: kMedium.copyWith(
                fontSize: 16,
                color: tertiaryColor,
              ),
            ),
            Text(
              profile.data.nim,
              style: kMedium.copyWith(
                fontSize: 16,
                color: tertiaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderAndAvatar extends StatelessWidget {
  const HeaderAndAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            height: 250,
            color: primaryColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: tertiaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 150,
            color: backgroundColor,
          ),
        )
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 150);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
