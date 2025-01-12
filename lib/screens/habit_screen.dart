import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_hub/blocs/habit_cubit.dart';
import 'package:habit_hub/config/constraint.dart';
import 'package:habit_hub/models/new_habit_model.dart';
import 'package:habit_hub/repositories/icons_repository.dart';

final GetIt getIt = GetIt.instance;

class HabitScreen extends StatefulWidget {
  final String? id;
  const HabitScreen({super.key, required this.id});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  onSaveHabitPressed(ThemeData themeData) async {
    nameController.text = nameController.text.trim();
    descriptionController.text = descriptionController.text.trim();
    if (nameController.text.isNotEmpty) {
      if (widget.id == null) {
        await context
            .read<NewHabitCubit>()
            .addNewHabit(nameController.text, descriptionController.text,
                context.read<NewHabitCubit>().state.iconCodePoint)
            .then((value) {
          while (context.canPop()) {
            context.pop();
          }
          context.pushReplacement('/home');
        });
      } else {
        await context
            .read<NewHabitCubit>()
            .updateHabit(
              widget.id!,
              nameController.text,
              descriptionController.text,
              context.read<NewHabitCubit>().state.iconCodePoint,
            )
            .then((value) {
          while (context.canPop()) {
            context.pop();
          }
          context.pushReplacement('/home');
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Name cannot be empty',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.id != null) {
      context.read<NewHabitCubit>().getHabitToEdit(widget.id!).then((value) {
        nameController.text = context.read<NewHabitCubit>().state.name;
        descriptionController.text =
            context.read<NewHabitCubit>().state.description;
      });
    }
    getIt.registerSingleton<Function>(onSaveHabitPressed,
        instanceName: 'onSaveHabitPressed');
    super.initState();
  }

  @override
  void dispose() {
    getIt.unregister<Function>(
      instanceName: 'onSaveHabitPressed',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        elevation: 0,
        title: Text(
          widget.id == null ? 'New habit' : 'Edit habit',
          style: TextStyle(
            color: themeData.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultHorizontalViewPadding,
          child: ListView(
            children: [
              HabitTextField(controller: nameController, hintText: 'Name'),
              HabitTextField(
                controller: descriptionController,
                hintText: 'Description',
                last: true,
              ),
              const HabitIconPicker(),
              const SaveHabitButton(),
              RemoveButton(id: widget.id)
            ],
          ),
        ),
      ),
    );
  }
}

class HabitTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool last;
  const HabitTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.last = false});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: defaultTopPadding / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            textInputAction: last ? TextInputAction.done : TextInputAction.next,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            cursorColor: themeData.colorScheme.primary,
            cursorWidth: 3,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              fillColor: themeData.colorScheme.surfaceVariant,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HabitIconItem extends StatelessWidget {
  final int index;
  final int iconCodePoint;
  const HabitIconItem(
      {super.key, required this.index, required this.iconCodePoint});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.read<NewHabitCubit>().setNewHabitIconCodePoint(
            IconsRepository().getFeaturedIcons()[index]);
      },
      child: Container(
        decoration: BoxDecoration(
          color: iconCodePoint == IconsRepository().getFeaturedIcons()[index]
              ? themeData.colorScheme.primary
              : themeData.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          IconsRepository().getIconData(
            IconsRepository().getFeaturedIcons()[index],
          ),
          color: iconCodePoint == IconsRepository().getFeaturedIcons()[index]
              ? themeData.colorScheme.onPrimary
              : themeData.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class HabitIconPicker extends StatelessWidget {
  const HabitIconPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Icon',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: IconsRepository().getFeaturedIcons().length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 13 : 7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return BlocBuilder<NewHabitCubit, NewHabit>(
              buildWhen: (previous, current) {
                // build only widgets that changed
                return previous.iconCodePoint ==
                        IconsRepository().getFeaturedIcons()[index] ||
                    current.iconCodePoint ==
                        IconsRepository().getFeaturedIcons()[index];
              },
              builder: (context, state) {
                return HabitIconItem(
                  index: index,
                  iconCodePoint: state.iconCodePoint,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class SaveHabitButton extends StatelessWidget {
  const SaveHabitButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: defaultTopPadding,
      child: ElevatedButton(
        onPressed: () {
          getIt.get<Function>(
            instanceName: 'onSaveHabitPressed',
          )(themeData);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: themeData.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(15),
        ),
        child: Text(
          'Save',
          style: TextStyle(
            color: themeData.colorScheme.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class RemoveButton extends StatelessWidget {
  final String? id;
  const RemoveButton({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        id == null
            ? const SizedBox()
            : const SizedBox(
                height: 10,
              ),
        id == null
            ? const SizedBox()
            : GestureDetector(
                onTap: () async {
                  // show dialog
                  showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return AlertDialog(
                        backgroundColor: themeData.colorScheme.surface,
                        title: Text(
                          'Are you sure you want to remove this habit?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(contextDialog);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await context
                                  .read<NewHabitCubit>()
                                  .deleteHabit(
                                    id!,
                                  )
                                  .then((value) {
                                Navigator.pop(contextDialog);
                                while (context.canPop()) {
                                  context.pop();
                                }
                                context.pushReplacement('/home');
                              });
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                color: themeData.colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Remove habit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ],
    );
  }
}
