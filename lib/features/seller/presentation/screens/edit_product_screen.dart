import 'dart:io';

import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';
import 'package:bulkbazar/features/product/domain/usecases/update_product_usecase.dart';
import 'package:bulkbazar/features/product/presentation/widgets/image_picker_widget.dart';
import 'package:bulkbazar/features/product/presentation/widgets/primary_button.dart';
import 'package:bulkbazar/features/product/presentation/widgets/product_textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  bool isLoading = false;

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

    setState(() {
      isLoading = true;
    });

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

    setState(() {
      isLoading = false;
    });
  }

  Widget pricingWidget() {
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
                  Text("MOQ: ${price.moq}"),
                  Text("Price: Rs. ${price.price}"),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => removePricing(index),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://10.0.2.2:5000/${widget.product.image}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: Container(
        color: Colors.blue.shade50,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ImagePickerWidget(
                      image: selectedImage,
                      imageUrl: imageUrl,
                      onTap: pickImage,
                    ),

                    const SizedBox(height: 20),

                    ProductTextField(
                      controller: nameController,
                      label: "Product Name",
                    ),

                    const SizedBox(height: 12),

                    ProductTextField(
                      controller: descriptionController,
                      label: "Description",
                    ),

                    const SizedBox(height: 12),

                    ProductTextField(
                      controller: categoryController,
                      label: "Category",
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

                    pricingWidget(),

                    const SizedBox(height: 20),

                    PrimaryButton(
                      text: "Update Product",
                      onPressed: update,
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
