import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../product/domain/usecases/update_product_usecase.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  final ProductEntity product;

  const EditProductScreen({super.key, required this.product});

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;

  final moqController = TextEditingController();
  final priceController = TextEditingController();

  File? selectedImage;

  late List<PricingEntity> pricingList;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product.name);

    descriptionController = TextEditingController(
      text: widget.product.description,
    );

    categoryController = TextEditingController(text: widget.product.category);

    pricingList = List.from(widget.product.pricing);
  }

  Future pickImage() async {
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

  Future update() async {
    if (!formKey.currentState!.validate()) return;

    await ref
        .read(updateProductUsecaseProvider)
        .call(
          productId: widget.product.id,

          name: nameController.text,

          description: descriptionController.text,

          category: categoryController.text,

          image: selectedImage,

          pricing: pricingList,
        );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Widget pricingWidget() {
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
    final imageUrl = "http://10.0.2.2:5000/${widget.product.image}";

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,

                child: selectedImage != null
                    ? Image.file(selectedImage!, height: 150)
                    : Image.network(imageUrl, height: 150),
              ),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),

              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),

              const SizedBox(height: 20),

              const Text("Pricing"),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: moqController,
                      decoration: const InputDecoration(labelText: "MOQ"),
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: "Price"),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: addPricing,
                  ),
                ],
              ),

              pricingWidget(),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: update,
                  child: const Text("Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
