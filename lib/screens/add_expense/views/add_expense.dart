import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expensee/data/data.dart';
import 'package:flutter_expensee/screens/add_expense/views/color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  //controllers
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  String iconSelected = "";
  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 26),
              const Text(
                'Add Expense',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              //expense input form field
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  controller: expenseController,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 30),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.rupeeSign,
                          size: 16,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //category input form field
              TextFormField(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      bool isExpanded = false;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Create a Category'),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //name
                                  TextFormField(
                                    //controller: expenseController,
                                    textAlignVertical: TextAlignVertical.center,

                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.font,
                                            size: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                        ],
                                      ),
                                      hintText: 'Name',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500]),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  //icon
                                  TextFormField(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    readOnly: true,
                                    //controller: expenseController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.icons,
                                            size: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                        ],
                                      ),
                                      suffixIcon: const Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 12,
                                      ),
                                      hintText: 'Icon',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500]),
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(30),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                crossAxisCount: 3,
                                              ),
                                              itemCount:
                                                  categoryImageList.length,
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
                                                        style:
                                                            BorderStyle.solid,
                                                        color: iconSelected ==
                                                                categoryImageList[
                                                                    i]
                                                            ? Colors.green
                                                            : Colors.grey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
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
                                  CustomColorPicker(),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                controller: categoryController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.plus,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.list,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                  hintText: 'Category',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //date - date-picker input form field
              TextFormField(
                controller: dateController,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (newDate != null) {
                    setState(
                      () {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(newDate);
                        selectDate = newDate;
                      },
                    );
                  }
                },
                readOnly: true,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendarDay,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                  hintText: 'Date',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //save button
              SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    backgroundColor: Colors.green[900],
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Save',
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
    );
  }
}
