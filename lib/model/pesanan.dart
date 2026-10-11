
class ItemPesanan {
  final String nama;
  final int harga;
  final int jumlah;

  ItemPesanan({
    required this.nama,
    required this.harga,
    required this.jumlah,
  });

  // Menghitung subtotal setiap jenis kue.
  int get subtotal => harga * jumlah;

  // Mengubah data item menjadi format JSON.
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
    };
  }

  // Mengubah JSON menjadi objek ItemPesanan.
  factory ItemPesanan.fromJson(Map<String, dynamic> json) {
    return ItemPesanan(
      nama: json['nama'] ?? '',
      harga: json['harga'] ?? 0,
      jumlah: json['jumlah'] ?? 0,
    );
  }
}

class Pesanan {
  final String id;
  final String tanggal;
  final List<ItemPesanan> items;
  final String alamat;
  final String metodePembayaran;
  final String catatan;
  final String status;

  Pesanan({
    required this.id,
    required this.tanggal,
    required this.items,
    required this.alamat,
    required this.metodePembayaran,
    required this.catatan,
    required this.status,
  });

  // Menghitung total harga seluruh item pesanan.
  int get total {
    return items.fold(
      0,
      (jumlahTotal, item) => jumlahTotal + item.subtotal,
    );
  }

  // Mengubah objek Pesanan menjadi format JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tanggal': tanggal,
      'items': items.map((item) => item.toJson()).toList(),
      'alamat': alamat,
      'metodePembayaran': metodePembayaran,
      'catatan': catatan,
      'status': status,
    };
  }

  // Mengubah JSON menjadi objek Pesanan.
  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      id: json['id'] ?? '',
      tanggal: json['tanggal'] ?? '',
      items: (json['items'] as List? ?? [])
          .map(
            (item) => ItemPesanan.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
      alamat: json['alamat'] ?? '',
      metodePembayaran: json['metodePembayaran'] ?? 'COD',
      catatan: json['catatan'] ?? '',
      status: json['status'] ?? '',
    );
  }
}