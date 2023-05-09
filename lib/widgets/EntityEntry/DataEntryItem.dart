import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/ClusterEntryItem.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/GroupEntryItem.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/LivestockEntryItem.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/LocationEntryItem.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/MemberEntryItem.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/ProgrammeEntryItem.dart';
import 'package:lsi_management_portal/widgets/EntityEntry/RegionEntryItem.dart';

import 'StateEntryItem.dart';

class DataEntryItem extends StatefulWidget {
  final String entity;
  const DataEntryItem({super.key, required this.entity});

  @override
  State<DataEntryItem> createState() => _DataEntryItemState();
}

class _DataEntryItemState extends State<DataEntryItem> {
  _buildDataEntryItem() {
    if (widget.entity == "state") {
      return StateEntryItem();
    }

    if (widget.entity == "programme") {
      return ProgrammeEntryItem();
    }

    if (widget.entity == "region") {
      return RegionEntryItem();
    }

    if (widget.entity == "location") {
      return LocationEntryItem();
    }

    if (widget.entity == "cluster") {
      return ClusterEntryItem();
    }

    if (widget.entity == "group") {
      return GroupEntryItem();
    }

    if (widget.entity == "member") {
      return MemberEntryItem();
    }

    if (widget.entity == "livestock") {
      return LivestockEntryItem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: _buildDataEntryItem(),
        ),
      ),
    );
  }
}
