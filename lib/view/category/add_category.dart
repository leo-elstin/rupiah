import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/components/color_picker/color_picker.dart';
import 'package:expense_kit/view/components/custom_icon.dart';
import 'package:expense_kit/view/components/icon_picker.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view_model/category/category_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddCategory extends StatefulWidget {
  static const route = '/add_category';

  const AddCategory({super.key});

  @override
  StateModel<AddCategory, CategoryCubit> createState() => _AddCategoryState();
}

class _AddCategoryState extends StateModel<AddCategory, CategoryCubit> {
  @override
  void initView(CategoryCubit cubit) {
    super.initView(cubit);
    cubit.reset();
  }

  @override
  Widget buildMobile(BuildContext context, CategoryCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Create Category',
              style: context.titleMedium(),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 32),
            TextField(
              style: context.titleMedium(),
              decoration: textDecoration.copyWith(
                labelText: 'Category Name',
                hintText: 'Enter Category Name',
                labelStyle: context.titleLarge(),
              ),
              onChanged: cubit.nameUpdate,
            ),
            const SizedBox(height: 32),
            TextField(
              style: context.titleMedium(),
              decoration: textDecoration.copyWith(
                labelText: 'Description',
                hintText: 'Description here',
                labelStyle: context.titleLarge(),
              ),
              onChanged: cubit.descriptionUpdate,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Category Icon'),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton.filledTonal(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => IconPicker(
                              onSelect: (String value) {
                                cubit.iconUpdate(value);
                              },
                            ),
                          ),
                          icon: CustomIcon(
                            iconCode: cubit.companion.iconCode.value != null
                                ? cubit.companion.iconCode.value!
                                : '983323',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Category Color'),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton.filledTonal(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => ColorPicker(
                              onSelect: (String value) {
                                cubit.colorUpdate(value);
                              },
                            ),
                          ),
                          icon: Container(
                            decoration: BoxDecoration(
                              color: cubit.companion.colorCode.value == null
                                  ? Colors.green
                                  : Color(
                                      int.parse(
                                          cubit.companion.colorCode.value!),
                                    ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                      cubit.reset();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                    ),
                    onPressed: cubit.valid
                        ? () {
                            context.pop();
                            cubit.create();
                          }
                        : null,
                    child: const Text('Create Category'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
