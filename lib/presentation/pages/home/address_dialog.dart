import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({super.key});

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  late TextEditingController addressController;
  late String? address;
  bool loading = false;

  @override
  void initState() {
    addressController = TextEditingController();
    address = context.read<AuthBloc>().user.address;
    super.initState();
  }

  void saveAddress(String address) {
    context.read<AuthBloc>().add(UpdateUser(
          user: context.read<AuthBloc>().user.copyWith(
                address: () => address,
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is UserLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: const LoadingBar(),
              );
            },
          );
        } else if (state is UserAuthenticated) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: ShadDialog(
        title: Text("Delivery Address"),
        description: Text("Enter your preferred delivery address"),
        actions: [
          ShadButton.secondary(
            child: const Text("Save"),
            onPressed: () {
              saveAddress(addressController.text);
            },
          ),
        ],
        child: ShadInput(
          controller: addressController,
          placeholder: Text("Address"),
        ),
      ),
    );
  }
}
