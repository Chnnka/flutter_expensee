import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_expensee/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expensee/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:uuid/uuid.dart';

getCategoryCreation(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      String iconSelected = "";
      Color categoryColor = Colors.white;
      bool isExpanded = false;
      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      bool isLoading = false;
      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx);
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  child: AlertDialog(
                    title: const Text('Create a Category'),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //name
                          TextFormField(
                            controller: categoryNameController,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                FontAwesomeIcons.font,
                                color: Colors.grey[500],
                              ),
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          //icon select
                          TextFormField(
                            controller: categoryIconController,
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                FontAwesomeIcons.icons,
                                size: 16,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              suffixIcon: const Icon(
                                CupertinoIcons.chevron_down,
                                size: 12,
                              ),
                              hintText: 'Icon',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderRadius: isExpanded
                                    ? const BorderRadius.vertical(
                                        top: Radius.circular(30))
                                    : BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          isExpanded
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(30))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                        crossAxisCount: 3,
                                      ),
                                      itemCount: categoryImageList.length,
                                      itemBuilder: (context, int i) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              iconSelected =
                                                  categoryImageList[i];
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                style: BorderStyle.solid,
                                                color: iconSelected ==
                                                        categoryImageList[i]
                                                    ? Colors.green
                                                    : const Color.fromARGB(
                                                        255, 206, 206, 206),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/${categoryImageList[i]}.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 16),
                          //color
                          TextFormField(
                            controller: categoryColorController,
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx2) {
                                  return SingleChildScrollView(
                                    child: AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ColorPicker(
                                            pickerColor: categoryColor,
                                            onColorChanged: (value) {
                                              setState(() {
                                                categoryColor = value;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                backgroundColor:
                                                    Colors.green[900],
                                              ),
                                              onPressed: () {
                                                Navigator.pop(ctx2);
                                              },
                                              child: const Text(
                                                'Save Color',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: categoryColor,
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.palette,
                                    size: 16,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ],
                              ),
                              hintText: 'Color',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          //create category button
                          SizedBox(
                            height: kToolbarHeight,
                            width: double.infinity,
                            child: isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      backgroundColor: Colors.green[900],
                                    ),
                                    onPressed: () {
                                      //create category object and pop
                                      Category category = Category.empty;
                                      category.categoryId = const Uuid().v1();
                                      category.name =
                                          categoryNameController.text;
                                      category.icon = iconSelected;
                                      category.color = categoryColor.value;
                                      context
                                          .read<CreateCategoryBloc>()
                                          .add(CreateCategory(category));
                                    },
                                    child: const Text(
                                      'Create Category',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
