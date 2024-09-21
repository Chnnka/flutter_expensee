import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expensee/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:flutter_expensee/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:flutter_expensee/screens/add_expense/views/add_expense.dart';
import 'package:flutter_expensee/screens/home/views/main_screen.dart';
import 'package:flutter_expensee/screens/stats/views/stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late Color selectedItem = Theme.of(context).colorScheme.primary;
  Color unSelectedItem = const Color.fromARGB(255, 88, 88, 88);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: index == 0 ? selectedItem : unSelectedItem,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_circle_fill,
                color: index == 1 ? selectedItem : unSelectedItem,
              ),
              label: 'Stats',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: const Icon(CupertinoIcons.add),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        CreateCategoryBloc(FirebaseExpenseRepository()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GetCategoriesBloc(FirebaseExpenseRepository())
                          ..add(GetCategories()),
                  ),
                ],
                child: const AddExpense(),
              ),
            ),
          );
        },
      ),
      body: index == 0 ? const MainScreen() : const StatScreen(),
    );
  }
}
