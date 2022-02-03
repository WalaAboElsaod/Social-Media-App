import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_media_app/Modules/edit_profile/edit_profile_screen.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/icon_broken.dart';
import 'package:social_media_app/widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
                // state is SocialGetUserSuccessStateStates,
                SocialCubit.get(context).userModel != null,
            // &&ShopCubit.get(context).favoriteModel != null,

            // ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriesModel != null,
            widgetBuilder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage('${model.cover}'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    )),
                              ),
                            ),
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('${model.image}'),
                                radius: 60.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text('${model.name}',
                          style: Theme.of(context).textTheme.bodyText1),
                      Text(
                        '${model.bio}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('100',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Text(
                                      'posts',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('100',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Text(
                                      'Photos',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('10k',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Text(
                                      'Followers',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('64',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Text(
                                      'Following',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: CustomText(
                                text: 'Add photo',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                navigateTo(context, EditProfile());
                              },
                              child: Icon(
                                IconBroken.Edit,
                                size: 16,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                FirebaseMessaging.instance.subscribeToTopic('announcements');
                              },
                              child: CustomText(
                                text: 'Subscribe',
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                              },
                              child: CustomText(
                                text: 'Unsubscribe',
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
            fallbackBuilder: (BuildContext context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
