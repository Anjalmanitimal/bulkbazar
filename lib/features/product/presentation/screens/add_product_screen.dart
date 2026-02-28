import 'dart:io';

import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';
import 'package:bulkbazar/features/product/domain/usecases/add_product_usecase.dart';
import 'package:bulkbazar/features/product/presentation/widgets/image_picker_widget.dart';
import 'package:bulkbazar/features/product/presentation/widgets/primary_button.dart';
import 'package:bulkbazar/features/product/presentation/widgets/product_textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  final moqController = TextEditingController();
  final priceController = TextEditingController();

  File? selectedImage;

  List<PricingEntity> pricingList = [];

  bool isLoading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void addPricing() {
    final moq = int.tryParse(moqController.text);
    final price = double.tryParse(priceController.text);

    if (moq != null && price != null) {
      setState(() {
        pricingList.add(PricingEntity(moq: moq, price: price));

        moqController.clear();
        priceController.clear();
      });
    }
  }

  void removePricing(int index) {
    setState(() {
      pricingList.removeAt(index);
    });
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select image")));
      return;
    }

    if (pricingList.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Add pricing")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ref
          .read(addProductUsecaseProvider)
          .call(
            name: nameController.text,
            description: descriptionController.text,
            category: categoryController.text,
            image: selectedImage!,
            pricing: pricingList,
          );

      if (mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Product Added")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildPricingList() {
    return Column(
      children: List.generate(pricingList.length, (index) {
        final price = pricingList[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MOQ: ${price.moq}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Price: Rs. ${price.price}"),
                ],
              ),
              IconButton(
                onPressed: () => removePricing(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: Container(
        color: Colors.blue.shade50,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ImagePickerWidget(image: selectedImage, onTap: pickImage),

                    const SizedBox(height: 20),

                    ProductTextField(
                      controller: nameController,
                      label: "Product Name",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 12),

                    ProductTextField(
                      controller: descriptionController,
                      label: "Description",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 12),

                    ProductTextField(
                      controller: categoryController,
                      label: "Category",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: ProductTextField(
                            controller: moqController,
                            label: "MOQ",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ProductTextField(
                            controller: priceController,
                            label: "Price",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        IconButton(
                          onPressed: addPricing,
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.blue,
                            size: 32,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    buildPricingList(),

                    const SizedBox(height: 20),

                    PrimaryButton(
                      text: "Add Product",
                      onPressed: submit,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
