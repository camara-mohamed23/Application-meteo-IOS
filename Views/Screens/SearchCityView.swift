import SwiftUI       // Import de SwiftUI pour créer l'interface
import SwiftData     // Import de SwiftData pour la gestion du modèle persistant

// Vue principale pour rechercher une ville et afficher la météo
struct SearchCityView: View {
    
    // Texte saisi par l'utilisateur pour la ville
    @State private var city = ""
    
    // ViewModel qui gère la récupération de la météo
    @StateObject private var vm = WeatherViewModel()
    
    // Contexte SwiftData injecté par l'environnement
    @Environment(\.modelContext) private var modelContext
    
    // Historique des villes, trié par date décroissante
    @Query(sort: \City.date, order: .reverse) var recentCities: [City]

    var body: some View {
        NavigationStack { // Navigation pour permettre un titre et navigation future
            VStack(spacing: 20) { // Empile les éléments verticalement avec un espace de 20 points
                
                // Champ de texte pour entrer le nom d'une ville
                TextField("Entrez une ville", text: $city)
                    .textFieldStyle(.roundedBorder) // Style arrondi pour le champ
                
                // Bouton pour lancer la recherche
                Button("Rechercher") {
                    Task { // Lance une tâche asynchrone
                        await vm.loadWeather(city: city) // Charge la météo depuis l'API
                        saveCity(city)                     // Sauvegarde la ville dans SwiftData
                    }
                }
                .buttonStyle(.borderedProminent) // Style moderne pour le bouton

                // Affiche un indicateur de chargement si la requête est en cours
                if vm.isLoading {
                    ProgressView("Chargement...")
                }

                // Affiche un message d'erreur si la requête a échoué
                if let error = vm.errorMessage {
                    ErrorView(message: error)
                }

                // Affiche la météo actuelle si disponible
                if let weather = vm.weather {
                    WeatherView(weather: weather)
                }

                // Affiche les prévisions météo si disponibles
                if let forecast = vm.forecast {
                    ForecastView(forecast: forecast)
                }

                // Affiche l'historique des villes recherchées
                if !recentCities.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Historique des villes")
                            .font(.headline)
                        ForEach(recentCities) { city in
                            Text(city.name) // Affiche le nom de chaque ville
                        }
                    }
                    .padding()
                }

                Spacer() // Remplit l'espace restant pour pousser le contenu vers le haut
            }
            .padding() // Espace autour de tout le VStack
            .navigationTitle("Recherche") // Titre de la vue
        }
    }

    // Fonction pour sauvegarder une ville dans SwiftData
    func saveCity(_ cityName: String) {
        guard !cityName.isEmpty else { return } // Ignore si le nom est vide

        // 1️⃣ Crée l'objet City
        let city = City(name: cityName)

        // 2️⃣ Insère l'objet dans le contexte SwiftData
        modelContext.insert(city)

        // 3️⃣ Sauvegarde le contexte (sans argument)
        do {
            try modelContext.save()
        } catch {
            print("Erreur sauvegarde ville: \(error)")
        }
    }
}
