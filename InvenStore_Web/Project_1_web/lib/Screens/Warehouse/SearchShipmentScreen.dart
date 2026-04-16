// ignore_for_file: file_names
import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Warehouse/Shipment%20Models/ShipmentModel.dart';
import 'package:buymore/Services/Warehouse/ShipmentServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Warehouse/Shipment/ShipmentContainer.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchShipmentsScreen extends StatefulWidget {
  const SearchShipmentsScreen({super.key, required this.search});
  final String search;
  @override
  State<SearchShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<SearchShipmentsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ShipmentModel> shipmentList = [];
  bool isFetching = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchShipments(currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchShipments(int page) async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    if (isFetching) return;

    setState(() {
      isFetching = true;
    });

    try {
      final response = await ShipmentServices()
          .showAllShipmentsService(page, widget.search, locale);
      if (response.status == 1) {
        setState(() {
          shipmentList.addAll(response.data.data);

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

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchShipments(currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 0 : 40, right: isArabic() ? 0 : 40),
                  child: Text(
                    S.of(context).shipmentNumber,
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
                  padding: EdgeInsets.only(right: isArabic() ? 0 : 130),
                  child: Text(
                    S.of(context).driverName,
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
                  padding: EdgeInsets.only(right: isArabic() ? 10 : 100),
                  child: Text(
                    S.of(context).distination,
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
                  padding: EdgeInsets.only(right: isArabic() ? 10 : 70),
                  child: Text(
                    S.of(context).orderId,
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
                  padding: const EdgeInsets.only(),
                  child: Text(
                    S.of(context).shipmentStatus,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: shipmentList.length + (isFetching ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < shipmentList.length) {
                    return ShipmentContainer(
                      shipment: shipmentList[index],
                    );
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
          ],
        ),
      ),
    );
  }
}
