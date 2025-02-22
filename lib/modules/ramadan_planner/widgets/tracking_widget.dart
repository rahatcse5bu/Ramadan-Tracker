import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../../app/constants/app_color.dart';
import '../controller/tracking_controller.dart';

class TrackingWidget extends StatelessWidget {
  final int ramadan_day;
  final String slug;
  final String type;

  const TrackingWidget({
    Key? key,
    required this.ramadan_day,
    required this.slug,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrackingController controller = Get.put(
      TrackingController(ramadanDay: ramadan_day, slug: slug, type: type),
      tag: '$slug-$ramadan_day', // Ensures unique controller instance
    );

    log("TrackingWidget rendered for $slug - Day: $ramadan_day");

    return Obx(() {
      if (controller.isLoadingOptions.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.trackingOptions.isEmpty) {
        return const Center(child: Text("No options available"));
      }

      return Column(
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        controller.getTrackingName(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // ✅ Mapping over tracking options
                  ...controller.trackingOptions.map<Widget>((option) {
                    bool checked = controller.isUserChecked(
                        option['users'], 'day${controller.ramadanDay}');

                    // ✅ Checkbox List
                    if (controller.type == "checkbox") {
                      return CheckboxListTile(
                        secondary: controller.loadingStates[option['_id']] == true
                            ? const CircularProgressIndicator()
                            : checked
                                ? Icon(Icons.check, color: AppColors.primary)
                                : const Icon(Icons.close, color: Colors.red),
                        activeColor: checked ? AppColors.primary : Colors.red,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("${option['title']} [${option['point']} Points]"),
                        subtitle: ExpandableText(
                          option['description'],
                          expandText: 'show more',
                          collapseText: 'show less',
                          maxLines: 2,
                          linkColor: Colors.blue,
                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                        value: checked,
                        onChanged: (bool? newValue) {
                          if (newValue != null) {
                            controller.updateTrackingOption(option['_id'], newValue);
                            controller.submitPoints(newValue ? option['point'] : -option['point']);
                          }
                        },
                      );
                    }

                    // ✅ Switch List
                    if (controller.type == "switch") {
                      return SwitchListTile(
                        secondary: controller.loadingStates[option['_id']] == true
                            ? const CircularProgressIndicator()
                            : checked
                                ? Icon(Icons.check, color: AppColors.primary)
                                : const Icon(Icons.close, color: Colors.red),
                        activeColor: checked ? AppColors.primary : Colors.red,
                        title: Text("${option['title']} [${option['point']} Points]"),
                        subtitle: ExpandableText(
                          option['description'],
                          expandText: 'show more',
                          collapseText: 'show less',
                          maxLines: 2,
                          linkColor: Colors.blue,
                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                        value: checked,
                        onChanged: (bool newValue) {
                          controller.updateTrackingOption(option['_id'], newValue);
                          controller.submitPoints(newValue ? option['point'] : -option['point']);
                        },
                      );
                    }

                    return const SizedBox(); // Prevents returning null
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
