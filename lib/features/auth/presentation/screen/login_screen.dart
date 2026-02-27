import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController(text: "mor_2314");
    final passwordController = TextEditingController(text: "83r5^_");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 40),

                  /// 🔥 Welcome Text
                  const Text(
                    "Welcome Back 👋",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Login to continue shopping",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// 🔹 Username Field
                  _buildTextField(
                    controller: usernameController,
                    hint: "Username",
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 Password Field
                  _buildTextField(
                    controller: passwordController,
                    hint: "Password",
                    icon: Icons.lock_outline,
                    obscure: true,
                  ),

                  const SizedBox(height: 30),

                  /// 🔹 Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().login(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🔹 Login With Phone (UI only)
                  _socialButton(
                    icon: Icons.phone,
                    text: "Continue with Phone",
                    color: Colors.green,
                  ),

                  const SizedBox(height: 12),

                  /// 🔹 Login With Google (UI only)
                  _socialButton(
                    icon: Icons.g_mobiledata,
                    text: "Continue with Google",
                    color: Colors.red,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}