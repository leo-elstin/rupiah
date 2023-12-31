import 'package:expense_kit/model/entity/category_entiry.dart';
import 'package:expense_kit/view/category/add_category.dart';
import 'package:expense_kit/view/components/custom_icon.dart';
import 'package:expense_kit/view_model/category/category_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  static const route = '/category-list';

  const CategoryList({super.key});

  @override
  StateModel<CategoryList, CategoryCubit> createState() => _CategoryListState();
}

class _CategoryListState extends StateModel<CategoryList, CategoryCubit> {
  @override
  void initView(CategoryCubit cubit) {
    super.initView(cubit);
    cubit.get();
  }

  @override
  Widget buildMobile(BuildContext context, CategoryCubit cubit) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddCategory(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: cubit.list.length,
        itemBuilder: (BuildContext context, int index) {
          CategoryEntity entity = cubit.list[index];
          return ListTile(
            title: Text(entity.name),
            leading: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(int.parse(entity.colorCode ?? '0xFF000000')),
                borderRadius: BorderRadius.circular(32),
              ),
              child: CustomIcon(
                iconCode: entity.iconCode ?? '983323',
              ),
            ),
            subtitle: Text(entity.description ?? 'NA'),
          );
        },
      ),
    );
  }
}
