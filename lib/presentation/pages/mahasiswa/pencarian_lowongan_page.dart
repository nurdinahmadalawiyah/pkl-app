import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/presentation/provider/pencarian_provider.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';
import 'package:provider/provider.dart';

import '../../../data/models/pencarian_lowongan.dart';

class PencarianLowonganPage extends StatefulWidget {
  const PencarianLowonganPage({Key? key}) : super(key: key);

  @override
  State<PencarianLowonganPage> createState() => _PencarianLowonganPageState();
}

class _PencarianLowonganPageState extends State<PencarianLowonganPage> {
  final TextEditingController _controller = TextEditingController();
  String keyword = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Cari Tempat PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: Consumer<PencarianProvider>(
        builder: (context, state, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    labelText: 'Cari Tempat PKL',
                    labelStyle: const TextStyle(color: Color(0xFF585656)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: primaryColor,
                      ),
                    ),
                    prefixIcon: const Icon(
                      IconlyLight.search,
                      color: primaryColor,
                    ),
                  ),
                  onChanged: (keyword) {
                    state.updateKeyword(keyword);
                    if (keyword != '') {
                      state.fetchAllPencarianLowongan(keyword);
                    }
                  },
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                child: Consumer<PencarianProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: LoadingAnimation(),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.pencarianLowongan!.data.length,
                        itemBuilder: (context, index) {
                          var lowongan = state.pencarianLowongan!.data[index];
                          return CardPencarianLowongan(lowongan: lowongan);
                        },
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(
                          child: SingleChildScrollView(child: NoDataAnimation(message: state.message)));
                    } else if (state.state == ResultState.noConnection) {
                      return Center(
                          child: SingleChildScrollView(child: NoConnectionAnimation(message: state.message)));
                    } else if (state.state == ResultState.error) {
                      return Center(
                        child: SingleChildScrollView(child: ErrorAnimation(message: state.message)),
                      );
                    } else {
                      return const Text('Unknown Error');
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CardPencarianLowongan extends StatelessWidget {
  const CardPencarianLowongan({
    Key? key,
    required this.lowongan,
  }) : super(key: key);

  final Lowongan lowongan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
        color: accentColor,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: ListTile(
          onTap: () async {
            if (lowongan.url == null) {
              Navigator.pushNamed(context, '/pengajuan-pkl');
            } else {
              try {
                await launch(
                  lowongan.url,
                  customTabsOption: CustomTabsOption(
                    enableDefaultShare: true,
                    enableUrlBarHiding: true,
                    showPageTitle: true,
                    animation: CustomTabsSystemAnimation.slideIn(),
                    extraCustomTabs: const <String> [
                          'org.mozilla.firefox',
                          'com.microsoft.emmx',
                    ],
                  ),
                );
              } catch (e) {
                debugPrint(e.toString());
              }
            }
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: lowongan.gambar,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Text(
            lowongan.posisi,
            style: kBold.copyWith(color: blackColor, fontSize: 16),
          ),
          subtitle: Text(
            lowongan.namaPerusahaan,
            style: kRegular.copyWith(color: blackColor, fontSize: 12),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      ),
    );
  }
}
