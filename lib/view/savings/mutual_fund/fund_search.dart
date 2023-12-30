import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/view_model/mutual_fund/mutual_fund_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FundSearch extends StatefulWidget {
  final ValueChanged<Scheme> onSelect;

  const FundSearch({super.key, required this.onSelect});

  @override
  StateModel<FundSearch, MutualFundCubit> createState() => _FundSearchState();
}

class _FundSearchState extends StateModel<FundSearch, MutualFundCubit> {
  @override
  void initView(MutualFundCubit cubit) {
    cubit.clear();
    super.initView(cubit);
  }

  @override
  Widget buildMobile(BuildContext context, MutualFundCubit cubit) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffix: cubit.state is MutualFundLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Offstage(),
                ),
                onChanged: (value) => cubit.searchFund(value),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.funds.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cubit.funds[index].schemeName,
                      ),
                      onTap: () {
                        widget.onSelect(cubit.funds[index]);
                        context.pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
