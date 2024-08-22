import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class City {
  String name;
  String country;
  List<String> placesToVisit;
  List<String> placesToEat;

  City(this.name, this.country, this.placesToVisit, this.placesToEat);
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Proyecto Flutter',
        theme: ThemeData(
          fontFamily: 'PTSans',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 63, 171, 100)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
class MyAppState extends ChangeNotifier {
  var currentIndex = 0;
  var listAddingCities = <City>[];

  GlobalKey? listAddingCitiesKey;

  var favorites = <City>[];
  List<City> cities = [
  City(
    "Madrid",
    "España",
    ["Museo del Prado", "Plaza Mayor", "Parque del Retiro"],
    ["Restaurante Botín", "Mercado de San Miguel", "Casa Lucio"],
  ),
  City(
    "Barcelona",
    "España",
    ["Sagrada Familia", "Parc Güell", "La Rambla"],
    ["Bar Canete", "El Quim de la Boqueria", "El Nacional"],
  ),
  City(
    "Valencia",
    "España",
    ["Ciudad de las Artes y las Ciencias", "Mercado Central", "Playa de la Malvarrosa"],
    ["La Pepica", "Casa Montaña", "Cervecería Antigua de Campanar"],
  ),
  City(
    "Sevilla",
    "España",
    ["Catedral de Sevilla", "Alcázar de Sevilla", "Plaza de España"],
    ["Bar El Comercio", "Bodega Santa Cruz Las Columnas", "Restaurante Eslava"],
  ),
  City(
    "Tokio",
    "Japón",
    ["Tokyo Skytree", "Shibuya Crossing", "Parque Yoyogi"],
    ["Sukiyabashi Jiro", "Ichiran", "Tempura Kondo"],
  ),
  City(
    "París",
    "Francia",
    ["Torre Eiffel", "Museo del Louvre", "Catedral de Notre-Dame"],
    ["Le Grand Véfour", "Les Deux Magots", "Le Procope"],
  ),
  City(
    "Nueva York",
    "Estados Unidos",
    ["Central Park", "Estátua de la Libertad", "Times Square"],
    ["Peter Luger Steak House", "Le Bernardin", "Katz's Delicatessen"],
  ),
  City(
    "Roma",
    "Italia",
    ["Coliseo", "Vaticano", "Fontana di Trevi"],
    ["La Pergola", "Giolitti", "Antico Arco"],
  ),
  City(
    "Londres",
    "Reino Unido",
    ["Torre de Londres", "Abadía de Westminster", "London Eye"],
    ["The Ledbury", "Dishoom", "Sketch"],
  ),
  City(
    "Sídney",
    "Australia",
    ["Ópera de Sídney", "Puente del Puerto de Sídney", "Bondi Beach"],
    ["Tetsuya's", "Quay", "Golden Century"],
  ),
  City(
    "Estambul",
    "Turquía",
    ["Mezquita Azul", "Santa Sofía", "Gran Bazar"],
    ["Hamdi Restaurant", "Karaköy Lokantası", "Ciya Sofrasi"],
  ),
  City(
    "Ciudad del Cabo",
    "Sudáfrica",
    ["Montaña de la Mesa", "Cabos de Buena Esperanza", "Robben Island"],
    ["Test Kitchen", "The Pot Luck Club", "La Colombe"],
  ),
  City(
    "Singapur",
    "Singapur",
    ["Marina Bay Sands", "Gardens by the Bay", "Universal Studios Singapore"],
    ["Jumbo Seafood", "Hawker Chan", "Lau Pa Sat"],
  ),
  City(
    "Dubái",
    "Emiratos Árabes Unidos",
    ["Burj Khalifa", "Palm Jumeirah", "Dubai Mall"],
    ["Nusr-Et Steakhouse", "Al Hadheerah", "Pierchic"],
  ),
  City(
    "Bangkok",
    "Tailandia",
    ["Templo del Buda Esmeralda", "Mercado Flotante Damnoen Saduak", "Gran Palacio"],
    ["Gaggan", "Nahm", "Jay Fai"],
  ),
  City(
    "San Petersburgo",
    "Rusia",
    ["Museo del Hermitage", "Catedral de San Isaac", "Palacio de Catalina"],
    ["L'Europe Restaurant", "Palkin", "Idiot"],
  ),
  City(
    "Berlín",
    "Alemania",
    ["Puerta de Brandeburgo", "Muro de Berlín", "Isla de los Museos"],
    ["Rutz", "Facil", "Kreuzberger Himmel"],
  ),
  City(
    "México D.F.",
    "México",
    ["Museo Frida Kahlo", "Plaza de la Constitución", "Bosque de Chapultepec"],
    ["Pujol", "Contramar", "El Cardenal"],
  ),
  City(
    "Los Ángeles",
    "Estados Unidos",
    ["Hollywood", "Universal Studios Hollywood", "Santa Mónica"],
    ["République", "Bestia", "Providence"],
  ),
  City(
    "Hong Kong",
    "China",
    ["Victoria Peak", "Monasterio de Po Lin", "Hong Kong Disneyland"],
    ["Tim Ho Wan", "Yung Kee", "Din Tai Fung"],
  ),
];

  void getNext() {
    var animatedList = listAddingCitiesKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    currentIndex = (currentIndex + 1) % cities.length;
    notifyListeners();
  }
  
  void toggleFavorite(City city) {
    if (favorites.contains(city)) {
      favorites.remove(city);
    } else {
      favorites.add(city);
    }
    notifyListeners();
  }
  void removeFavoriteCity(City city){
    favorites.remove(city);
    notifyListeners();
  }
  void anadirPalabra(City city){
    cities.add(city);
    notifyListeners();
  }
  void removeCity(City city){
    cities.remove(city);
    if(favorites.contains(city)){
      favorites.remove(city);
    }
    notifyListeners();
  }
  void editCity(City oldCity, City newCity) {
    int index = cities.indexOf(oldCity);
    if (index != -1) {
      cities[index] = newCity;
      if(favorites.contains(oldCity)){
        int indexFav = favorites.indexOf(oldCity);
        favorites[indexFav] = newCity;
      }
      notifyListeners();
    }
  }
  void addingCities(City city){
    listAddingCities.insert(0, city);
    notifyListeners();
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget page;
    String text = "Página Principal";
    switch (_selectedIndex) {
      case 0:
        text = "Página Principal";
        page = GeneratorPage();
        break;
      case 1:
        text = "Todas las ciudades";
        page = AllCitiesPage();
        break;
      case 2:
        text = "Favoritos";
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError('No widget for $_selectedIndex');
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(text,
        style: TextStyle(
                fontFamily: 'ProtestRiot',
                fontSize: 32,
                color: Colors.white,
                ),),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/img/img5.jpg'), 
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
              ),
              child: Text(
                'PROYECTO FLUTTER 2ª EVA\nOlha Millionna',
                style: TextStyle(
                    fontFamily: 'ProtestRiot',
                    fontSize: 32,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)], 
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              child: ListTile(
                leading: Image.asset(
                  'assets/img/menuHome.png', // Ruta de la imagen en tu proyecto
                  width: 50, // Ancho deseado de la imagen
                  height: 50,
                ),
                title: Text('Principal'),
                onTap: () {
                  _selectDestination(0);
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              child: ListTile(
                leading: Image.asset(
                  'assets/img/menuList.png', // Ruta de la imagen en tu proyecto
                  width: 50, // Ancho deseado de la imagen
                  height: 50,
                ),
                title: Text('Todas las ciudades'),
                onTap: () {
                  _selectDestination(1);
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              child: ListTile(
                leading: Image.asset(
                  'assets/img/menuFav.png', // Ruta de la imagen en tu proyecto
                  width: 50, // Ancho deseado de la imagen
                  height: 50,
                ),
                title: Text('Favoritos'),
                onTap: () {
                  _selectDestination(2);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          /*NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Principal'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Todas las ciudades'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favoritos'),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              _selectDestination(index);
            },
          ),*/
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: page,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class GeneratorPage extends StatefulWidget {
  @override
  _GeneratorPageState createState() => _GeneratorPageState();
}
class _GeneratorPageState extends State<GeneratorPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Duración de la animación
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller); // Tween para la animación
     _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var city = appState.cities[appState.currentIndex];
    Widget icon;
    if (appState.favorites.contains(city)) {
      icon = Image.asset(
        'assets/img/fav2.png', // Ruta de la imagen del ícono lleno de favoritos
        width: 24, // Ancho de la imagen
        height: 24, // Altura de la imagen
      );
    } else {
      icon = Image.asset(
        'assets/img/fav1.png', // Ruta de la imagen del ícono de favoritos vacío
        width: 24, // Ancho de la imagen
        height: 24, // Altura de la imagen
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/img1.jpg'), 
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40),
                  child: Text("CIUDADES",
                  style: TextStyle(
                    fontFamily: 'ProtestRiot',
                    fontSize: 90,
                    letterSpacing: 10.0,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)], 
                    ),
                  ),
                ),
                SizedBox(height: 10),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: child,
                    );
                  },
                  child: CityCard(city: city),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          appState.toggleFavorite(city);
                        },
                        icon: icon,
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Me gusta',
                          style: TextStyle(
                                fontSize: 20,)
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          appState.getNext();
                          appState.addingCities(city);
                          _controller.forward(from: 0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Siguiente',
                          style: TextStyle(
                                  fontSize: 20,)
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 3,
                  child: HistoryListView(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical:35),
        child: FloatingActionButton(
          onPressed: () {
            openAnimationDialog(context, appState);
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(225, 253, 250, 250), // Cambia el color según tus preferencias
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/img1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              'No hay favoritos todavía...',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'ProtestRiot',
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/img1.jpg'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'TIENES ${appState.favorites.length} FAVORITOS:',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: 'ProtestRiot',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ListView.builder(
                  itemCount: appState.favorites.length,
                  itemBuilder: (BuildContext context, int index) {
                    var city = appState.favorites[index];
                    return Card(
                      color: Color.fromARGB(92, 255, 255, 255),
                      shape: RoundedRectangleBorder( // Establecer un radio de borde para el Card
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4, 
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.black, // Color del icono de expansión cuando no está seleccionado
                            dividerColor: Color.fromARGB(58, 255, 255, 255), // Color del divisor entre las opciones del ExpansionTile
                            expansionTileTheme: ExpansionTileThemeData(
                              collapsedBackgroundColor: Color.fromARGB(0, 255, 255, 255),
                            ),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              city.name,
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: Image.asset(
                              'assets/img/item.png', // Ruta de la imagen en tu proyecto
                              width: 24, // Ancho deseado de la imagen
                              height: 24,
                            ),
                            backgroundColor: Color.fromARGB(137, 255, 255, 255),
                            children: [
                              Divider( // Línea divisoria después de la sección de "País"
                                color: Colors.white,
                                indent: 10, 
                                endIndent: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: ListTile(
                                  title: Text(
                                    '\u2023 País: ${city.country}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold, 
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: ListTile(
                                  title: Text(
                                    '\u2023 Lugares para visitar:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left:15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: city.placesToVisit.map((place) {
                                        return Text(
                                          '\u2022 $place',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: ListTile(
                                  title: Text(
                                    '\u2023 Lugares para comer:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: city.placesToEat.map((place) {
                                        return Text(
                                          '\u2022 $place',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/img/edit.png', // Ruta de la imagen en tu proyecto
                                      width: 24, // Ancho deseado de la imagen
                                      height: 24, // Alto deseado de la imagen
                                    ),
                                    onPressed: () {
                                      editCity(context, city, appState);
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/img/delete.png', // Ruta de la imagen en tu proyecto
                                      width: 24, // Ancho deseado de la imagen
                                      height: 24, // Alto deseado de la imagen
                                    ),
                                    onPressed: () {
                                      showDeleteConfirmationDialog(context, city, appState, 'favorite');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllCitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/img1.jpg'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10, // Espacio entre las filas
                ),
                itemCount: appState.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  var city = appState.cities[index];
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ItemCity(city: city, appState: appState),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  openAnimationDialog(context, appState);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(0, 63, 171, 0.8),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Añadir nueva ciudad',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: FloatingActionButton(
          onPressed: () {
            openAnimationDialog(context, appState);
          },
          backgroundColor: Color.fromRGBO(0, 63, 171, 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.white, width: 2.0),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

void openAnimationDialog(BuildContext context, MyAppState appState) {
  String newCityName = '';
  String newCityCountry = '';
  List<String> newPlacesToVisit = [];
  List<String> newPlacesToEat = [];

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: AlertDialog(
            title: Text('Añadir nueva ciudad'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    newCityName = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nombre de la ciudad',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    newCityCountry = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'País',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    // Split input by comma to get a list of places
                    newPlacesToVisit = value.split(',');
                  },
                  decoration: InputDecoration(
                    hintText: 'Lugares para visitar (separados por coma)',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    // Split input by comma to get a list of places
                    newPlacesToEat = value.split(',');
                  },
                  decoration: InputDecoration(
                    hintText: 'Lugares para comer (separados por coma)',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Create a new City object and add it to the app state
                  City newCity = City(newCityName, newCityCountry, newPlacesToVisit, newPlacesToEat);
                  appState.anadirPalabra(newCity);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Añadir'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ItemCity extends StatelessWidget {
  ItemCity({
    super.key,
    required this.city,
    required this.appState,
  });

  final City city;
  final MyAppState appState;
  late Widget icon;
  
  @override
  Widget build(BuildContext context) {
    if (appState.favorites.contains(city)) {
      icon = Image.asset(
        'assets/img/fav2.png', // Ruta de la imagen del ícono lleno de favoritos
        width: 24, // Ancho de la imagen
        height: 24, // Altura de la imagen
      );
    } else {
      icon = Image.asset(
        'assets/img/fav1.png', // Ruta de la imagen del ícono de favoritos vacío
        width: 24, // Ancho de la imagen
        height: 24, // Altura de la imagen
      );
    }
    return Card(
      elevation: 10,
      color: Color.fromARGB(211, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(city.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: icon,
              onPressed: () {
                appState.toggleFavorite(city);
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/img/delete.png', // Ruta de la imagen en tu proyecto
                width: 24, // Ancho deseado de la imagen
                height: 24, // Alto deseado de la imagen
              ),
              onPressed: () {
                showDeleteConfirmationDialog(context, city, appState, 'city');
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/img/edit.png', // Ruta de la imagen en tu proyecto
                width: 24, // Ancho deseado de la imagen
                height: 24, // Alto deseado de la imagen
              ),
              onPressed: () {
                editCity(context, city, appState);
              },
            ),
          ],
        ),
      ),
    );
  }
 }
  void editCity(BuildContext context, City city, MyAppState appState) {
  TextEditingController nameController = TextEditingController(text: city.name);
  TextEditingController countryController = TextEditingController(text: city.country);
  TextEditingController placesToVisitController = TextEditingController(text: city.placesToVisit.join(', '));
  TextEditingController placesToEatController = TextEditingController(text: city.placesToEat.join(', '));

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar ciudad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Nombre de la ciudad',
              ),
            ),
            TextField(
              controller: countryController,
              decoration: InputDecoration(
                hintText: 'País',
              ),
            ),
            TextField(
              controller: placesToVisitController,
              decoration: InputDecoration(
                hintText: 'Lugares para visitar (separados por coma)',
              ),
            ),
            TextField(
              controller: placesToEatController,
              decoration: InputDecoration(
                hintText: 'Lugares para comer (separados por coma)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              String newName = nameController.text;
              String newCountry = countryController.text;
              List<String> newPlacesToVisit = placesToVisitController.text.split(',');
              List<String> newPlacesToEat = placesToEatController.text.split(',');
              
              if (newName.isNotEmpty && newCountry.isNotEmpty) {
                // Create a new City object with updated details
                City updatedCity = City(newName, newCountry, newPlacesToVisit, newPlacesToEat);
                // Edit the city in the app state
                appState.editCity(city, updatedCity);
                Navigator.of(context).pop(); // Cierra el diálogo
              }
            },
            child: Text('Guardar'),
          ),
        ],
      );
    },
  );
}

  void showDeleteConfirmationDialog(BuildContext context, City city, MyAppState appState, String list) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que quieres eliminar $city?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if(list == 'city'){
                  appState.removeCity(city); 
                }if(list == 'favorite'){
                  appState.removeFavoriteCity(city);
                }
                Navigator.of(context).pop(); 
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
  
class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 10,
      color: theme.colorScheme.primary.withOpacity(0.8),
      shape: RoundedRectangleBorder( // Añadido para especificar el borde del card
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.white, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
        child: Text(
          city.name,
          style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
        ),
      ),
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey<AnimatedListState>();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.black, Colors.transparent], 
    stops: [0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.listAddingCitiesKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: false, // Cambiado a false para que las nuevas palabras aparezcan en la parte superior
        padding: EdgeInsets.only(top: 10),
        initialItemCount: appState.listAddingCities.length,
        itemBuilder: (context, index, animation) {
          final city = appState.listAddingCities[index];
          return SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0, // Cambiado a -1.0 para que la animación vaya de arriba a abajo
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(city);
                },
                icon: appState.favorites.contains(city)
                    ? Image.asset(
                        'assets/img/fav2.png', // Ruta de la imagen del icono de favorito
                        width: 18, 
                        height: 18, 
                      )
                    : SizedBox(),
                label: Text(
                  city.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}