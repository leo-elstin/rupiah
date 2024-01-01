import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconPicker extends StatelessWidget {
  final ValueChanged<String> onSelect;

  const IconPicker({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: ListView.builder(
          itemCount: icons.length,
          itemBuilder: (context, index) {
            MapEntry<String, List<IconData>> entry =
                icons.entries.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(entry.key),
                ),
                Wrap(
                  children: entry.value
                      .map(
                        (IconData e) => IconButton.filledTonal(
                          onPressed: () {
                            context.pop();
                            onSelect(e.codePoint.toString());
                          },
                          icon: Icon(e),
                        ),
                      )
                      .toList(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

final icons = {
  "Animal": [
    MdiIcons.butterfly,
    MdiIcons.cat,
    MdiIcons.cow,
    MdiIcons.dog,
    MdiIcons.dogSide,
    MdiIcons.duck,
    MdiIcons.fish,
    MdiIcons.horse,
    MdiIcons.owl,
    MdiIcons.panda,
    MdiIcons.pig,
    MdiIcons.sheep,
    MdiIcons.rabbit,
    MdiIcons.snail,
    MdiIcons.snake,
    MdiIcons.spider,
    MdiIcons.tortoise,
    MdiIcons.turtle,
    MdiIcons.turkey,
  ],
  "Brands": [
    MdiIcons.android,
    MdiIcons.angular,
    MdiIcons.apple,
    MdiIcons.atlassian,
    MdiIcons.aws,
    MdiIcons.bitbucket,
    MdiIcons.bitcoin,
    MdiIcons.blenderSoftware,
    MdiIcons.bootstrap,
    MdiIcons.codepen,
    MdiIcons.devTo,
    MdiIcons.deviantart,
    MdiIcons.docker,
    MdiIcons.dropbox,
    MdiIcons.evernote,
    MdiIcons.facebook,
    MdiIcons.firebase,
    MdiIcons.firefox,
    MdiIcons.github,
    MdiIcons.gitlab,
    MdiIcons.gmail,
    MdiIcons.google,
    MdiIcons.googleAds,
    MdiIcons.googleDrive,
    MdiIcons.googlePlay,
    MdiIcons.hulu,
    MdiIcons.instagram,
    MdiIcons.jira,
    MdiIcons.kickstarter,
    MdiIcons.languageSwift,
    MdiIcons.linkedin,
    MdiIcons.microsoft,
    MdiIcons.microsoftAzure,
    MdiIcons.nintendoSwitch,
    MdiIcons.onepassword,
    MdiIcons.pandora,
    MdiIcons.patreon,
    MdiIcons.pinterest,
    MdiIcons.qqchat,
    MdiIcons.reddit,
    MdiIcons.skype,
    MdiIcons.snapchat,
    MdiIcons.soundcloud,
    MdiIcons.spotify,
    MdiIcons.steam,
    MdiIcons.wechat,
    MdiIcons.whatsapp,
    MdiIcons.wikipedia,
    MdiIcons.wordpress,
    MdiIcons.youtube,
  ],
  "Computer": [
    MdiIcons.album,
    MdiIcons.audioVideo,
    MdiIcons.earbuds,
    MdiIcons.headphones,
    MdiIcons.musicNote,
    MdiIcons.speaker,
    MdiIcons.printer,
    MdiIcons.radio,
    MdiIcons.wifi,
    MdiIcons.bluetooth,
    MdiIcons.phone,
    MdiIcons.laptop,
    MdiIcons.desktopClassic,
    MdiIcons.televisionSpeaker,
    MdiIcons.videoVintage,
    MdiIcons.film,
    MdiIcons.camcorder,
    MdiIcons.video,
    MdiIcons.webcam,
    MdiIcons.camera,
  ],
  "Food": [
    MdiIcons.carrot,
    MdiIcons.chiliMild,
    MdiIcons.corn,
    MdiIcons.egg,
    MdiIcons.foodApple,
    MdiIcons.fruitGrapes,
    MdiIcons.fruitCherries,
  ],
  "Health": [
    MdiIcons.pillMultiple,
    MdiIcons.needle,
    MdiIcons.motherNurse,
    MdiIcons.truckPlus,
    MdiIcons.medication,
    MdiIcons.hospitalBuilding,
    MdiIcons.emoticonSick,
  ],
  "Shopping": [
    MdiIcons.basket,
    MdiIcons.cart,
    MdiIcons.cash,
    MdiIcons.creditCard,
    MdiIcons.sale,
    MdiIcons.shopping,
    MdiIcons.store,
    MdiIcons.cashRegister,
    MdiIcons.cartVariant,
  ],
  "Transportation": [
    MdiIcons.airplane,
    MdiIcons.car,
    MdiIcons.ferry,
    MdiIcons.taxi,
    MdiIcons.tram,
    MdiIcons.train,
    MdiIcons.bus,
  ],
  "Other": [
    MdiIcons.circle,
    MdiIcons.circleHalf,
    MdiIcons.heart,
    MdiIcons.hexagon,
    MdiIcons.decagram,
    MdiIcons.shape,
    MdiIcons.hexagonMultiple,
    MdiIcons.triangle,
    MdiIcons.shapePlus,
  ],
};
