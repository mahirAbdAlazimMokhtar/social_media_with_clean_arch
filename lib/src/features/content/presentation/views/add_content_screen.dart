import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/src/features/auth/presentation/controller/blocs/auth/auth_bloc.dart';
import 'package:insta/src/features/content/presentation/blocs/add_content_cubit/add_content_cubit.dart';
import 'package:insta/src/shared/presentation/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:BackButton(onPressed: (){
          context.goNamed('feed');
        }) ,
        actions: [
          IconButton(
              onPressed: () {
                context.read<AddContentCubit>().reset();
              },
              icon: const Icon(Icons.clear))
        ],
        title: const Text('Add Content'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AddContentCubit, AddContentState>(
        buildWhen: (previous, current) => previous.video != current.video,
        listener: (context, state) {
          if (state.status == AddContentStatus.success) {
            context.goNamed('feed');
          }
        },
        builder: (context, state) {
          if (state.video == null) {
            return Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    await _handleVideo().then((video) {
                      if (video != null) {
                        context.read<AddContentCubit>().videoChanged(video);
                      }
                    });
                  },
                  child: Text(
                    'Select a Video',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            );
          }
          //end if
          else if (state.video != null) {
            if (kDebugMode) {
              print(state.video!.path);
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomVideoPlayer(assetPath: state.video!.path),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(56.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        onPressed: () {
                          _addCaption(context);
                        },
                        child: Text(
                          'Share',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went Wrong!');
          }
        },
      ),
    );
  }

  Future<dynamic> _addCaption(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      context: context,
      builder: (newContext) {
        return Container(
          color: Colors.white.withAlpha(175),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Your caption',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                      onChanged: (value) {
                        context.read<AddContentCubit>().captionChanged(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Write a caption...',
                        
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(56.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    context.read<AddContentCubit>().submit(
                      context.read<AuthBloc>().state.user
                    );
                    
                  },
                  child: Text(
                    'Share',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ],
          ),
        );
      },
    );
  }

  Future<File?> _handleVideo() async {
    XFile? uploadedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (uploadedVideo == null) {
      return null;
    }
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(uploadedVideo.path);
    final savedVideo =
        await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    print(savedVideo);
    return savedVideo;
  }
}
