import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:social_media_app/comment/comment_screen.dart';
import 'package:social_media_app/components/componants.dart';
import 'package:social_media_app/cubit/states.dart';
import 'package:social_media_app/model/post_model.dart';
import 'package:social_media_app/shared/cubit/cubit.dart';
import 'package:social_media_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:  (context,state){},
      builder: (context,state){
        return Conditional.single(context: context,
            conditionBuilder:
                (context)=>
           // state is
            //SocialGetPostsSuccessStateStates
                SocialCubit.get(context).posts.length > 0
                && SocialCubit.get(context).userModel !=null
            ,
            widgetBuilder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/young-smiley-girl-portrait-pointing_23-2148333062.jpg'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            )
                          // CustomText(text: 'Communicate with friends', alignment: Alignment.bottomLeft,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => buildPostItim(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            fallbackBuilder: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildPostItim(SocialPostModel model,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${model.image}'),
                    radius: 25.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(height: 1.4),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: HexColor("#3498DB"),
                            size: 18,
                          ),
                        ],
                      ),
                      Text('${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4)),
                    ],
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                   '${model.text}',
                  style: Theme.of(context).textTheme.subtitle1),


              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 25.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#software',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: Colors.blue)),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 25.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#software',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: Colors.blue)),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage !='')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              '${model.image}'
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('${SocialCubit.get(context).likes[index]}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey))
                            ],
                          ),
                        ),
                        onTap: () {
                          SocialCubit.get(context).likePost(SocialCubit.get(context).PostsId[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 18,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('${SocialCubit.get(context).comments.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey))
                            ],
                          ),
                        ),
                        onTap: () {
                          // SocialCubit.get(context).commentPost(SocialCubit.get(context).PostsId[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel.image}'
                            ),
                            radius: 18.0,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('write a Modules.comment ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.4)),
                        ],
                      ),
                      onTap: () {
                 navigateTo(context, CommentScreen(SocialCubit.get(context).PostsId[index]));
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('like',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey))
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).PostsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
