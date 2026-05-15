// lib/screens/sepet_sayfasi.dart
import 'package:flutter/material.dart';
import '../models/urun_model.dart';
import '../models/sepet_manager.dart'; // Sepet listesini çektik

// Ekranda değişiklik (silme işlemi) olacağı için StatefulWidget kullanıyoruz
class SepetSayfasi extends StatefulWidget {
  const SepetSayfasi({super.key});

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {

  // Listedeki ürünlerin fiyatlarını toplayan dinamik fonksiyon
  String _toplamTutariHesapla() {
    int toplam = 0;
    for (var urun in SepetManager.sepettekiUrunler) {
      // "8.500 ₺" yazısını önce noktadan ve ₺ işaretinden temizleyip "8500" sayısına çeviriyoruz
      String temizFiyat = urun.fiyat.replaceAll('.', '').replaceAll(' ₺', '');
      toplam += int.parse(temizFiyat);
    }
    
    // Toplam tutarı tekrar "10.600 ₺" formatına getiriyoruz
    String formatli = toplam.toString();
    if (formatli.length > 3) {
      formatli = '${formatli.substring(0, formatli.length - 3)}.${formatli.substring(formatli.length - 3)}';
    }
    return '$formatli ₺';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('Sepetim', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SepetManager.sepettekiUrunler.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('Sepetiniz şu an boş.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: SepetManager.sepettekiUrunler.length,
                    separatorBuilder: (context, index) => const Divider(height: 32, color: Colors.black12),
                    itemBuilder: (context, index) {
                      final urun = SepetManager.sepettekiUrunler[index];
                      return _sepetUrunu(urun, index);
                    },
                  ),
                ),
                
                // Alt kısımdaki dinamik ödeme barı
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Toplam:', style: TextStyle(fontSize: 18, color: Colors.grey)),
                            Text(_toplamTutariHesapla(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(child: Text('Kargo ücreti ödeme adımında hesaplanacaktır.', style: TextStyle(fontSize: 12, color: Colors.grey.shade600))),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            onPressed: () {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Siparişiniz tamamlandı!')));
                            },
                            child: const Text('Ödemeye Geç', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget _sepetUrunu(Urun urun, int index) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            urun.resimUrl, width: 80, height: 80, fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(width: 80, height: 80, color: Colors.grey.shade200, child: const Icon(Icons.image_not_supported)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(urun.ad, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(urun.aciklama, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 8),
              Text(urun.fiyat, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            // Yönergedeki "State Güncelleme" mantığı: Sil butonuna basıldığında ekranı yenile
            setState(() {
              SepetManager.sepettekiUrunler.removeAt(index);
            });
          },
        ),
      ],
    );
  }
}