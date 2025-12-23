import Foundation // Import nécessaire pour Codable, UUID, etc.

// Structure représentant la réponse de l'API pour les prévisions météo
struct ForecastResponse: Codable {
    let list: [ForecastItem] // Liste des prévisions pour plusieurs dates/heures
}

// Structure représentant une prévision individuelle
struct ForecastItem: Codable, Identifiable {
    
    // Identifiant unique pour ForEach dans SwiftUI
    let id = UUID()
    
    // Données principales de la météo (température, humidité, etc.)
    let main: Main
    
    // Tableau des conditions météo (ex: soleil, nuages, pluie)
    let weather: [Weather]
    
    // Date et heure de la prévision (format chaîne, ex: "2025-12-23 15:00:00")
    let dt_txt: String
}
