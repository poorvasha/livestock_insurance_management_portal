import 'package:flutter/material.dart';
import 'package:lsi_management_portal/configs/api_routes.dart';
import 'package:lsi_management_portal/models/data/insurance_model.dart';
import 'package:lsi_management_portal/widgets/DetailItemWidget.dart';

class InsuranceDetailScreen extends StatefulWidget {
  final Insurance insurance;
  const InsuranceDetailScreen({super.key, required this.insurance});

  @override
  State<InsuranceDetailScreen> createState() => _InsuranceDetailScreenState();
}

class _InsuranceDetailScreenState extends State<InsuranceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Insurance insurance = widget.insurance;

    List<Widget> renderPersonalDetails() {
      return [
        const Text("Personal Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 22,
        ),
        DetailItem(
          title: "Name",
          value: insurance.member?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Password",
          value: insurance.member?.password ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Code",
          value: insurance.member?.code ?? "",
        )
      ];
    }

    List<Widget> renderInsuranceDetails() {
      return [
        const Text("Insurance Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 22,
        ),
        DetailItem(
          title: "Cost",
          value: insurance.cost.toString(),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Premium Amount",
          value: insurance.premiumAmount.toString(),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Sum Assured",
          value: insurance.sumAssured.toString(),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Tag Number",
          value: insurance.tagNumber.toString(),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Enrolled Date",
          value: insurance.enrolledDate.toString(),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Status",
          value: insurance.status.name.toUpperCase(),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Renewal Days",
          value: insurance.renewalDays.toString(),
        )
      ];
    }

    List<Widget> renderLocalityDetails() {
      return [
        const Text("Locality Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 22,
        ),
        DetailItem(
          title: "State",
          value: insurance.member?.state?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Programme",
          value: insurance.member?.programme?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Region",
          value: insurance.member?.region?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Location",
          value: insurance.member?.location?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Cluster",
          value: insurance.cluster?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Group",
          value: insurance.group?.name ?? "",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailItem(
          title: "Livestock",
          value: insurance.livestock?.name ?? "",
        ),
      ];
    }

    List<Widget> renderImageDetails() {
      return [
        const Text("Image",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 22,
        ),
        Image.network("${ApiRoutes.baseUrl}${insurance.image?.front}"),
        const SizedBox(
          height: 16,
        ),
        Image.network("${ApiRoutes.baseUrl}${insurance.image?.back}"),
        const SizedBox(
          height: 16,
        ),
        Image.network("${ApiRoutes.baseUrl}${insurance.image?.left}"),
        const SizedBox(
          height: 16,
        ),
        Image.network("${ApiRoutes.baseUrl}${insurance.image?.right}"),
        const SizedBox(
          height: 16,
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(insurance.member?.name ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...renderPersonalDetails(),
                    const Divider(
                      color: Colors.black,
                      height: 50,
                    ),
                    ...renderInsuranceDetails()
                  ],
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...renderLocalityDetails(),
                  const Divider(
                    color: Colors.black,
                    height: 50,
                  ),
                  ...renderImageDetails()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
