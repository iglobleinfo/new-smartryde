import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  final int otpLength;
  final Function(String) onCompleted;
  final Color focusColor;
  final Color unFocusColor;
  final TextEditingController controller;
  final FocusNode focusNode;

  const OtpInput({
    super.key,
    this.otpLength = 6, // Default to 6 digits
    required this.onCompleted,
    this.focusColor = Colors.green,
    this.unFocusColor = Colors.grey,
    required this.focusNode,
    required this.controller,
  }) : assert(otpLength >= 4 && otpLength <= 8,
  'OTP length must be between 4 and 8');

  @override
  createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  List<String> _otpValues = [];

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;
    _focusNode = widget.focusNode;
    _otpValues = List.generate(widget.otpLength, (index) => '');

    // Listen for changes in the single controller
    _controller.addListener(() {
      setState(() {
        _otpValues = _controller.text.split('').map((e) => e).toList();
        if (_otpValues.length < widget.otpLength) {
          _otpValues.addAll(
              List.generate(widget.otpLength - _otpValues.length, (_) => ''));
        }
      });
    });
  }

  void _onSubmit() {
    final otp = _controller.text;
    if (otp.length == widget.otpLength) {
      widget.onCompleted(otp); // Notify parent widget
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
        },
        child: SizedBox(
          width: 71,
          height: 71,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: _controller.text.length == index ||
                    _controller.text.length > index ||
                    (_focusNode.hasFocus && index == 0)
                    ? widget.focusColor // Green border when focused
                    : widget.unFocusColor, // White border when unfocused
                width: 2.0,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              (_focusNode.hasFocus && index == 0 && _controller.text.isEmpty) ||
                  (_controller.text.length == index && _focusNode.hasFocus)
                  ? "|"
                  : _otpValues[index], // Display each character from the OTP
              // style: AppTheme.of(context).textStyleOtpField,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.otpLength, (index) {
            return _buildOtpBox(index);
          }),
        ),
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          maxLength: widget.otpLength,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          // Hide the textfield cursor and text
          cursorColor: Colors.transparent,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          style: const TextStyle(
              color: Colors.transparent), // Hide the actual input text
          onChanged: (value) {
            if (value.length == widget.otpLength) {
              _onSubmit(); // Submit when the OTP is completely entered
            }
          },
        ),
      ],
    );
  }
}
