import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Assigmentweek5 extends StatefulWidget {
  const Assigmentweek5({super.key});

  @override
  State<Assigmentweek5> createState() => _Assigmentweek5State();
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;

  Product(this.id, this.name, this.description, this.price);

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = (json['price'] as num).toDouble();
}

class _Assigmentweek5State extends State<Assigmentweek5> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // 🔹 ดึงข้อมูลสินค้าทั้งหมด
  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse('http://localhost:8001/products'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          productList = jsonList.map((item) => Product.fromJson(item)).toList();
        });
      } else {
        throw Exception("โหลดสินค้าล้มเหลว");
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 เพิ่มสินค้าใหม่
  Future<void> createProduct(String name, String desc, double price) async {
    try {
      var response = await http.post(
        Uri.parse("http://localhost:8001/products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": desc,
          "price": price,
        }),
      );
      if (response.statusCode == 201) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('เพิ่มสินค้าสำเร็จ!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 แก้ไขสินค้า
  Future<void> updateProduct(int id, String name, String desc, double price) async {
    try {
      var response = await http.put(
        Uri.parse("http://localhost:8001/products/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": desc,
          "price": price,
        }),
      );
      if (response.statusCode == 200) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('แก้ไขสินค้าสำเร็จ!'), backgroundColor: Colors.blue),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 ลบสินค้า
  Future<void> deleteProduct(int id) async {
    try {
      var response = await http.delete(Uri.parse("http://localhost:8001/products/$id"));
      if (response.statusCode == 200) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ลบสินค้าสำเร็จ!'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 Dialog สำหรับเพิ่มสินค้า
  void showAddDialog() {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController descCtrl = TextEditingController();
    TextEditingController priceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('เพิ่มสินค้าใหม่'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "ชื่อสินค้า")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "รายละเอียด")),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: "ราคา (บาท)"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
          ElevatedButton(
            onPressed: () {
              createProduct(
                nameCtrl.text,
                descCtrl.text,
                double.tryParse(priceCtrl.text) ?? 0,
              );
              Navigator.pop(context);
            },
            child: const Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  // 🔹 Dialog สำหรับแก้ไขสินค้า
  void showEditDialog(Product product) {
    TextEditingController nameCtrl = TextEditingController(text: product.name);
    TextEditingController descCtrl = TextEditingController(text: product.description);
    TextEditingController priceCtrl = TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('แก้ไขสินค้า'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "ชื่อสินค้า")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "รายละเอียด")),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: "ราคา (บาท)"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
          ElevatedButton(
            onPressed: () {
              updateProduct(
                product.id,
                nameCtrl.text,
                descCtrl.text,
                double.tryParse(priceCtrl.text) ?? 0,
              );
              Navigator.pop(context);
            },
            child: const Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  // 🔹 ยืนยันการลบสินค้า
  void confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ยืนยันการลบ"),
        content: const Text("คุณแน่ใจหรือไม่ว่าต้องการลบสินค้านี้?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("ยกเลิก")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              deleteProduct(id);
              Navigator.pop(context);
            },
            child: const Text("ลบ"),
          ),
        ],
      ),
    );
  }

  // 🔹 ส่วนแสดงผลหลัก
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสินค้า'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: fetchData),
        ],
      ),
      body: ListView.separated(
        itemCount: productList.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final product = productList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(product.id.toString()),
            ),
            title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${product.description}\nราคา: ฿${product.price.toStringAsFixed(2)}"),
            isThreeLine: true,
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => showEditDialog(product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => confirmDelete(product.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
