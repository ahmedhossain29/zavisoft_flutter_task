import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:zavisaft_flutter_task/core/common_widgets/custom_text.dart';
import '../../../../core/utils/utils.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const CustomText(text: "My Profile"),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {

          if (state is! AuthSuccess) {
            return _LoginRequired();
          }

          return FutureBuilder(
            future: fetchUser(),
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = snapshot.data;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [


                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [


                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.orange.shade100,
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.orange,
                            ),
                          ),

                          const SizedBox(height: 16),


                          CustomText(
                            text: "${user["name"]["firstname"]} ${user["name"]["lastname"]}",

                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                          ),

                          Utils.verticalSpace(8.0),


                          CustomText(text:
                            user["email"],
                              fontSize: 14,
                              color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),

                    Utils.verticalSpace(40.0),


                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                        child: const CustomText(text:
                          "Logout",

                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<dynamic> fetchUser() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/users/1"),
    );

    return json.decode(response.body);
  }
}

class _LoginRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/login");
        },
        child: const CustomText(text: "Login to View Profile"),
      ),
    );
  }
}