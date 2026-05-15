// lib/screens/urun_detay_sayfasi.dart
import 'package:flutter/material.dart';
import '../models/urun_model.dart';
import '../models/sepet_manager.dart'; // Sepet yöneticimizi içeri aktardık

class UrunDetaySayfasi extends StatelessWidget {
  final Urun urun;

  const UrunDetaySayfasi({super.key, required this.urun});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Geri', style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  urun.resimUrl, 
                  height: 220, 
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(height: 220, child: Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey))),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(urun.ad, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Text(urun.fiyat, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 8),
            Text(urun.aciklama, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            const Text('Teknik Detaylar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ozellikKutusu(Icons.speed, 'Tepkime', '1 ms'),
                _ozellikKutusu(Icons.gamepad, 'Kullanım', 'Pro'),
                _ozellikKutusu(Icons.verified, 'Garanti', '2 Yıl'),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // İŞTE STATE GÜNCELLEMESİ BURADA OLUYOR
                  SepetManager.sepettekiUrunler.add(urun); // Ürünü listeye ekledik
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${urun.ad} sepete eklendi!'), backgroundColor: Colors.green.shade700),
                  );
                },
                child: const Text('Sepete Ekle', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ozellikKutusu(IconData ikon, String baslik, String deger) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(ikon, color: Colors.deepPurple, size: 24),
          const SizedBox(height: 8),
          Text(baslik, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(deger, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}