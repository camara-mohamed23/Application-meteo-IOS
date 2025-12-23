import SwiftUI   // Import de SwiftUI pour l'interface graphique
import SwiftData // Import de SwiftData pour la persistance des données

// Point d'entrée de l'application
@main
struct WeatherAppApp: App {
    
    // Création du ModelContainer partagé pour SwiftData
    var sharedModelContainer: ModelContainer = {
        // Définition du schéma SwiftData avec le modèle City
        let schema = Schema([City.self])
        
        // Configuration du modèle, ici stocké de manière persistante (pas seulement en mémoire)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            // Création du container pour gérer les objets SwiftData
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Si une erreur survient, on arrête l'application et affiche le message
            fatalError("Impossible de créer ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // Vue principale de l'application
            SearchCityView()
                .modelContainer(sharedModelContainer) // Injection du contexte SwiftData
        }
    }
}
