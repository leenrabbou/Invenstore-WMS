// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Employee/EmployeeModel.dart';
import 'package:buymore/Services/Manager/EmployeesServices.dart';
import 'package:buymore/Services/Manager/RoleServices.dart';
import 'package:buymore/Services/Warehouse/WarehouseServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:buymore/helper/Manager/Employee/EmployeeContainer.dart';
import 'package:buymore/helper/Manager/Employee/EmployeeShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  List<EmployeeModel> employees = [];

  bool isFetching = false;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchEmployees(currentPage);
    _scrollController.addListener(_onScroll);
    fetchData();
  }

  void fetchData() async {
    try {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      await WarehouseServices().showAllCentersService(locale);
      await WarehouseServices().showAllWarehousesService(locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchEmployees(int page) async {
    if (isFetching) return;
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isFetching = true;
    });

    try {
      final response =
          await EmployeesServices().showAllEmployeesService(page, locale);
      await RolesServices().warehouseRolesService(locale);
      await RolesServices().centerRolesService(locale);
      if (response.status == 1) {
        setState(() {
          employees.addAll(response.data.data);

          currentPage = response.data.currentPage;
          isFetching = currentPage < response.data.lastPage;
        });
      }
    } catch (e) {
      if (mounted) {
        if (kDebugMode) {
          print('Error fetching subcategories: $e');
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          isFetching = false;
        });
      } else {
        isFetching = false;
      }
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      employees.clear();
      currentPage = 1;
      isFetching = false;
    });
    await fetchEmployees(currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchEmployees(currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SearchTextField(
          searchController: _searchController,
          onPressed: () {},
        ),
        actions: [
          permissionsMap['employee.store'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 30,
                      left: isArabic() ? 30 : 0),
                  child: TextButton(
                    onPressed: () {
                      EmployeeShowDialog().addEmployeeDialog(context,
                          text: S.of(context).addEmployee,
                          edit: false,
                          employee: null);
                    },
                    child: Text(
                      S.of(context).addEmployee,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          permissionsMap['role.store'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 30,
                      left: isArabic() ? 30 : 0),
                  child: TextButton(
                    onPressed: () {
                      EmployeeShowDialog().addRole(context);
                    },
                    child: Text(
                      S.of(context).addRole,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 0 : 30, right: isArabic() ? 50 : 0),
                  child: Text(
                    S.of(context).employee,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 0 : 20, right: isArabic() ? 0 : 0),
                  child: Text(
                    S.of(context).contactInfo,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: isArabic() ? 0 : 0),
                  child: Text(
                    S.of(context).workplace,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: isArabic() ? 10 : 0),
                  child: Text(
                    S.of(context).status,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: LiquidPullToRefresh(
                onRefresh: _onRefresh,
                color: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.primary,
                height: 100,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: employees.length + (isFetching ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < employees.length) {
                      return EmployeeContainer(employee: employees[index]);
                    } else {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
