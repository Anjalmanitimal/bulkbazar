import 'dart:io';

import 'package:bulkbazar/features/product/domain/usecases/add_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/product_entity.dart';

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
  }

  Widget buildPricingList() {
    return Column(
      children: List.generate(pricingList.length, (index) {
        final price = pricingList[index];

        return Card(
          child: ListTile(
            title: Text("MOQ: ${price.moq}"),
            subtitle: Text("Price: ₹${price.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => removePricing(index),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: selectedImage != null
                    ? Image.file(selectedImage!, height: 150)
                    : Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(child: Text("Select Image")),
                      ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 20),

              const Text(
                "Add Pricing",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: moqController,
                      decoration: const InputDecoration(labelText: "MOQ"),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: addPricing,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              buildPricingList(),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  child: const Text("Add Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
