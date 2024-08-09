import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuthenticated = false;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          labelStyle: TextStyle(color: Colors.black),
          prefixIconColor: Colors.green,
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.green,
          showUnselectedLabels: true,
          showSelectedLabels: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
            textStyle: TextStyle(color: Colors.white), // Set button text color to white
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          // Set button text color to white
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => isAuthenticated
            ? MainScreen(isAdmin: isAdmin)
            : AuthScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/login': (context) => LoginScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/register': (context) => RegisterScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/main': (context) => MainScreen(isAdmin: isAdmin),
        '/search': (context) => SearchScreen(),
        '/admin': (context) => isAuthenticated && isAdmin
            ? AdminScreen()
            : AuthScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/addDrug': (context) => AddDrugScreen(),
        '/editDrug': (context) => EditDrugScreen(),
        '/deleteDrug': (context) => DeleteDrugScreen(),
        '/verifieDrug': (context) => DeleteDrugScreen(),
        '/scanner': (context) => QRViewExample(),
      },
    );
  }
}

class AuthScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  AuthScreen({required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png', height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Connexion',
                  style: TextStyle(color: Colors.white,
                  ),

              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Inscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  LoginScreen({required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ajoute une marge horizontale globale
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale pour le champ
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale pour le champ
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                // Assume authentication logic here
                bool admin = true; // Placeholder logic
                onAuthenticated(admin);
              },
              child: Text(
                'Se connecter',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            TextButton(
              onPressed: () {
                // Logic to recover password
              },
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class RegisterScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  RegisterScreen({required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ajoute des marges horizontales globales
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirmer mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                // Assume registration logic here
                bool admin = false; // Placeholder logic
                onAuthenticated(admin);
              },
              child: Text(
                'S\'inscrire',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MainScreen extends StatefulWidget {
  final bool isAdmin;

  MainScreen({required this.isAdmin});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    QRViewExample(),
    AdminScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Utilisation de SingleChildScrollView pour éviter les débordements
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,  // Centrage horizontal
            children: [
              // Logo en haut du titre
              Image.asset(
                'images/logo.png',
                height: 100,  // Taille fixe pour éviter les problèmes de mise en page
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),

              // Titre accrocheur
              Text(
                'Authentifiez vos Médicaments avec Confiance',
                style: TextStyle(
                  fontSize: 24,  // Taille fixe du texte
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Sous-titre
              Text(
                'Prévenez la vente de médicaments contrefaits en scannant les codes-barres.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // Présentation du fonctionnement
              Text(
                'Scannez le code-barres de votre médicament pour vérifier son authenticité instantanément.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Illustration avec images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'images/scann.png',
                        width: 80,  // Taille fixe
                        height: 80, // Taille fixe
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Scannez',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Image.asset(
                        'images/chek.jpeg',
                        width: 80,  // Taille fixe
                        height: 80, // Taille fixe
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Vérifiez',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche de Médicaments',
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Entrez le nom ou le code du médicament',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for searching
              },
              child: Text('Rechercher',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String barcode = '';

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner le code-barres'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Résultat du scan: $barcode'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        barcode = scanData.code!;
        fetchDrugDetails(barcode);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void fetchDrugDetails(String barcode) {
    // Logic to get drug details using the scanned barcode
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugDetailScreen(
          drugName: "Aspirin",
          expiryDate: "2025-12-31",
          manufacturer: "Pharma Inc.",
          isAuthentic: true,
        ),
      ),
    );
  }
}

class DrugDetailScreen extends StatelessWidget {
  final String drugName;
  final String expiryDate;
  final String manufacturer;
  final bool isAuthentic;

  DrugDetailScreen({
    required this.drugName,
    required this.expiryDate,
    required this.manufacturer,
    required this.isAuthentic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Médicament'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom : $drugName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date d\'expiration : $expiryDate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Fabricant : $manufacturer', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              isAuthentic ? 'Authentique' : 'Contrefait',
              style: TextStyle(
                fontSize: 18,
                color: isAuthentic ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Gestion des Médicaments'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tableau de bord
              Text(
                'Tableau de bord',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDashboardTile(Icons.medical_services, 'Médicaments Vérifiés', ''),
                  _buildDashboardTile(Icons.add, 'Médicaments Ajoutés', ''),
                  _buildDashboardTile(Icons.edit, 'Médicaments Modifiés', ''),
                  _buildDashboardTile(Icons.delete, 'Médicaments Supprimés', ''),
                ],
              ),
              SizedBox(height: 20),

              // Actions
              Text(
                'Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildActionTile(context, Icons.add, 'Ajouter Médicament', '/addDrug'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.edit, 'Modifier Médicament', '/editDrug'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.delete, 'Supprimer Médicament', '/deleteDrug'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.medical_services, 'Vérifier Médicament', '/verifyDrug'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une tuile du tableau de bord
  Widget _buildDashboardTile(IconData icon, String title, String route) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigation vers la page correspondante
          if (route.isNotEmpty) {
            Navigator.pushNamed;
          }
        },
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une tuile d'action
  Widget _buildActionTile(BuildContext context, IconData icon, String title, String route) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 32),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}

  Widget _buildDashboardTile(IconData icon, String label, String count) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.green),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(count, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildActionTile(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon, size: 40, color: Colors.green),
      title: Text(label, style: TextStyle(fontSize: 18)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }


class AddDrugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nom du médicament'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Code-barres du medicament'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Fabricant'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Date de fabrication'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Date d\'expiration'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to add a drug
              },
              child: Text('Ajouter',
                style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

class EditDrugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nom du médicament'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Code-barres du medicament'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Fabricant'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Date de fabrication'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Date d\'expiration'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to edit a drug
              },
              child: Text('Modifier',
                  style: TextStyle(color: Colors.white),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteDrugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supprimer un  Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nom du médicament ou Code-barres du medicament'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to delete a drug
              },
              child: Text('Supprimer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
