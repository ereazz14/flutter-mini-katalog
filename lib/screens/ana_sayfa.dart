// lib/screens/ana_sayfa.dart
import 'package:flutter/material.dart';
import '../models/urun_model.dart';
import '../models/sepet_manager.dart'; // Sepetteki ürün sayısını okumak için ekledik
import 'urun_detay_sayfasi.dart';
import 'sepet_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  late List<Urun> urunlerListesi;

  @override
  void initState() {
    super.initState();
    urunlerListesi = mockUrunlerJson.map((json) => Urun.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Donanım', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    
                    // --- YENİ EKLENEN BADGE (BİLDİRİM ROZETİ) BÖLÜMÜ ---
                    Badge(
                      // Sadece sepet boş değilse rozeti göster
                      isLabelVisible: SepetManager.sepettekiUrunler.isNotEmpty,
                      label: Text(SepetManager.sepettekiUrunler.length.toString()),
                      backgroundColor: Colors.redAccent,
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const SepetSayfasi())
                          ).then((_) {
                            // Sepet sayfasından geri dönüldüğünde rozet güncellensin diye sayfayı yeniliyoruz
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    // ---------------------------------------------------
                    
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Kurulumunu bir üst seviyeye taşı.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 24),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 12),
                      Text('Ekipman ara...', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=800&auto=format&fit=crop',
                    width: double.infinity, height: 140, fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 32),
                
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: urunlerListesi.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    final urun = urunlerListesi[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => UrunDetaySayfasi(urun: urun))
                        ).then((_) {
                          // Ürün detay sayfasından (sepete ürün ekleyip) dönüldüğünde rozeti güncelle
                          setState(() {});
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(urun.resimUrl, width: double.infinity, fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(urun.ad, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(urun.aciklama, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1),
                                  const SizedBox(height: 6),
                                  Text(urun.fiyat, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}