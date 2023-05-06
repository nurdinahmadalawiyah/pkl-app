import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
              backgroundColor: tertiaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
