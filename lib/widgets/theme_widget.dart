import 'package:flutter/material.dart';

/// Gradient colors used across screens
const kPirateGradient = LinearGradient(
  colors: [Colors.cyanAccent, Colors.blueAccent],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

/// Dark background theme
const kBackgroundColor = Color(0xFF0E0E10);
const kCardColor = Color(0xFF1C1C22);

/// App title with glowing gradient text
class PirateTitle extends StatelessWidget {
  final String text;
  const PirateTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => kPirateGradient.createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

/// Common input field style
class PirateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const PirateTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.cyanAccent),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: kCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// Common gradient button
class PirateButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const PirateButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: isLoading ? null : onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: kPirateGradient,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
