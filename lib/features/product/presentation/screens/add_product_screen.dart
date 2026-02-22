import 'dart:io';
import 'package:bulkbazar/features/product/domain/usecases/add_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  File? selectedImage;

  List<PricingEntity> pricingList = [];

  final moqController = TextEditingController();
  final priceController = TextEditingController();

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

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image")));
      return;
    }

    if (pricingList.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please add MOQ pricing")));
      return;
    }

    try {
      print("Selected image path: ${selectedImage!.path}");
      print("File exists: ${await selectedImage!.exists()}");

      await ref
          .read(addProductUsecaseProvider)
          .call(
            name: nameController.text,
            description: descriptionController.text,
            image: selectedImage!,
            pricing: pricingList,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product added successfully")),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      print("UPLOAD ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
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
                        child: const Center(child: Text("Tap to select image")),
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
              const SizedBox(height: 16),

              const Text(
                "Add MOQ Pricing",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: moqController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "MOQ"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Price"),
                    ),
                  ),
                  IconButton(
                    onPressed: addPricing,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Column(
                children: pricingList.map((p) {
                  return ListTile(
                    title: Text("Min ${p.moq} pcs"),
                    trailing: Text("₹ ${p.price}"),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: submit,
                child: const Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
