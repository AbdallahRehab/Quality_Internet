
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate/rate.dart';
import 'package:sizer/sizer.dart';

import '../../components/speedLabels.dart';
import '../provider/test_net_provider.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<TestNetProvider>(
        builder: (context, provider, child) {
      return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .15,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Text(
                'Download Speed: ${provider.state.downloadRate} ${provider.state.unitText}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8,),
              Text(
                'Upload Speed: ${provider.state.uploadRate} ${provider.state.unitText}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 2.h,),
              Text(
                  provider.state.isServerSelectionInProgress
                      ? 'Selecting Server...'
                      : 'IP: ${provider.state.ip ?? '--'} | ASP: ${provider.state.asn ?? '--'} ',),

              SizedBox(height: 8,),
              provider.state.typeOfConnection !=null ? Text(
                  "Type of Connection :  ${provider.state.typeOfConnection ?? ""}",):const SizedBox(),
              SizedBox(height: 8,),

              provider.state.qualityOfYoutube != null?
              Text(
                  "Quality of Youtube :  ${provider.state.qualityOfYoutube!.round()}P",):SizedBox(),
               SizedBox(height: 3.h,),


              Rate(
                iconSize: 40,
                color: Colors.blueAccent,
                allowHalf: false,
                allowClear: true,
                initialValue: 0,
                readOnly: false,
                onChange: (value) => provider.setRateFun(newvalue: value.round()),
              ),
               SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      fixedSize: MaterialStateProperty.all<Size>(Size(45.w, 6.h)),
                    ),
                    onPressed: () {
                      provider.setDataOnFirebaseFun(context);
                    },
                    child: const Text('Send',style: TextStyle(fontSize: 18,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
        },
    );
  }
}
