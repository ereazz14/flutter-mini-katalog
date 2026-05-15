// lib/models/urun_model.dart

class Urun {
  final String ad;
  final String aciklama;
  final String fiyat;
  final String resimUrl;

  Urun({
    required this.ad,
    required this.aciklama,
    required this.fiyat,
    required this.resimUrl,
  });

  // JSON'dan Model sınıfına dönüştürme işlemi (Yönerge zorunluluğu)
  factory Urun.fromJson(Map<String, dynamic> json) {
    return Urun(
      ad: json['ad'],
      aciklama: json['aciklama'],
      fiyat: json['fiyat'],
      resimUrl: json['resimUrl'],
    );
  }
}

// İnternetten geliyormuş gibi simüle ettiğimiz JSON verisi
const List<Map<String, dynamic>> mockUrunlerJson = [
  {
    "ad": "Pro Monitör",
    "aciklama": "240Hz 1ms IPS",
    "fiyat": "8.500 ₺",
    "resimUrl": "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=500&auto=format&fit=crop"
  },
  {
    "ad": "Gaming Mouse",
    "aciklama": "Ultra Hafif, 25K DPI",
    "fiyat": "2.100 ₺",
    "resimUrl": "https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?q=80&w=500&auto=format&fit=crop"
  },
  {
    "ad": "Mekanik Klavye",
    "aciklama": "Red Switch, TKL",
    "fiyat": "3.400 ₺",
    "resimUrl": "https://images.unsplash.com/photo-1595225476474-87563907a212?w=500&auto=format&fit=crop"
  },
  {
    "ad": "Gaming Kulaklık",
    "aciklama": "7.1 Surround, RGB",
    "fiyat": "2.800 ₺",
    "resimUrl": "https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format&fit=crop"
  }
];