import 'package:flutter/material.dart';

class Derslik {
  final String ad;
  final int kapasite;
  final String resimUrl;

  Derslik({
    required this.ad,
    required this.kapasite,
    required this.resimUrl,
  });
}

final List<Derslik> tumDerslikler = [
  Derslik(ad: "Derslik-B1", kapasite: 36, resimUrl: "assets/images/derslik1.jpg"),
  Derslik(ad: "Derslik-B2", kapasite: 15, resimUrl: "assets/images/derslik2.jpg"),
  Derslik(ad: "Derslik-B3", kapasite: 18, resimUrl: "assets/images/derslik3.jpg"),
  Derslik(ad: "Derslik-B4", kapasite: 24, resimUrl: "assets/images/derslik4.jpg"),
];

class Altyapi extends StatelessWidget {
  const Altyapi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tumDerslikler.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1,
          color: Colors.grey[300],
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final derslik = tumDerslikler[index];
        return GestureDetector(
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DerslikDetaySayfasi(derslik: derslik),
              ),
            );
          },
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Text(
              derslik.ad,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            subtitle: Text(
              "Kapasite: ${derslik.kapasite}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        );
      },
    );
  }
}

class DerslikDetaySayfasi extends StatelessWidget {
  final Derslik derslik;

  const DerslikDetaySayfasi({super.key, required this.derslik});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(derslik.ad),
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 4.0,
          child: Image.asset(
            derslik.resimUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.broken_image,
                  size: 150,
                  color: Colors.grey[400],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
