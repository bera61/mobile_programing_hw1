import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Kisi {
  final String adSoyad;
  final String unvan;
  final String mail;
  final String gsm;
  final String resimUrl;

  Kisi({
    required this.adSoyad,
    required this.unvan,
    required this.mail,
    required this.gsm,
    required this.resimUrl,
  });
}

final List<Kisi> tumKisiler = [
  Kisi(
    adSoyad: "Murat ÖZTÜRK",
    unvan: "Dr. Öğr. Üyesi",
    mail: "murat.ozturk@eskisehir.edu.tr",
    gsm: "0505 412 87 36",
    resimUrl: "assets/images/odev1.jpg",
  ),
  Kisi(
    adSoyad: "Emre KARAHAN",
    unvan: "Doç. Dr.",
    mail: "emre.karahan@eskisehir.edu.tr",
    gsm: "0532 684 29 15",
    resimUrl: "assets/images/odev2.jpg",
  ),
  Kisi(
    adSoyad: "Hakan YILDIZ",
    unvan: "Dr. Öğr. Üyesi",
    mail: "hakan.yildiz@eskisehir.edu.tr",
    gsm: "0541 297 63 82",
    resimUrl: "assets/images/odev3.jpg",
  ),
  Kisi(
    adSoyad: "Serkan DEMİRCİ",
    unvan: "Prof. Dr.",
    mail: "serkan.demirci@eskisehir.edu.tr",
    gsm: "0554 318 40 27",
    resimUrl: "assets/images/odev4.jpg",
  ),
];

class Kisiler extends StatelessWidget {
  const Kisiler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: tumKisiler.length,
        itemBuilder: (BuildContext context, int index) {
          final kisi = tumKisiler[index];
          return KisiKarti(kisi: kisi);
        },
      ),
    );
  }
}


class KisiKarti extends StatelessWidget {
  final Kisi kisi;

  const KisiKarti({super.key, required this.kisi});

  Future<void> _launchDialer(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Arama başlatılamadı: $url');
    }
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dial a Number'),
          content: Text('Would you like to call ${kisi.unvan} ${kisi.adSoyad}?\nGSM: ${kisi.gsm}'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); 
                _launchDialer(kisi.gsm); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                kisi.resimUrl,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kisi.unvan,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    kisi.adSoyad,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Mail: ${kisi.mail}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "GSM: ${kisi.gsm}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _showCallDialog(context);
                        },
                        child: Text("CALL"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      ),
                    
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}