import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/category_model.dart';
import '../../services/product_service.dart';
import '../../services/category_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  int? selectedCategoryId;
  late Future<List<Category>> categories;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    categories = CategoryService.getCategories();

    if (widget.product != null) {
      nameController.text = widget.product!.name;
      descController.text = widget.product!.description;
      priceController.text = widget.product!.price.toString();
      stockController.text = widget.product!.stock.toString();
      selectedCategoryId = widget.product!.categoryId;
    }
  }

  Future<void> submit() async {
    if (selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kategori')),
      );
      return;
    }

    setState(() => isLoading = true);

    final res = widget.product == null
        ? await ProductService.createProduct(
            name: nameController.text,
            description: descController.text,
            price: priceController.text,
            stock: stockController.text,
            categoryId: selectedCategoryId!,
          )
        : await ProductService.updateProduct(
            id: widget.product!.id,
            name: nameController.text,
            description: descController.text,
            price: priceController.text,
            stock: stockController.text,
            categoryId: selectedCategoryId!,
          );

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res['message'])));

    if (res['status'] == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null
            ? 'Tambah Produk'
            : 'Edit Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: descController,
                decoration:
                    const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // ===== DROPDOWN KATEGORI =====
              FutureBuilder<List<Category>>(
                future: categories,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  return DropdownButtonFormField<int>(
                    value: selectedCategoryId,
                    decoration:
                        const InputDecoration(labelText: 'Kategori'),
                    items: snapshot.data!
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedCategoryId = value),
                  );
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : submit,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white)
                      : const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
