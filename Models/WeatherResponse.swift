import Foundation // Import nécessaire pour Codable

// Structure représentant la réponse de l'API pour la météo actuelle
struct WeatherResponse: Codable {
    let name: String          // Nom de la ville
    let main: Main            // Données principales (température, humidité, etc.)
    let weather: [Weather]    // Tableau des conditions météo (ex: soleil, nuages)
}

// Structure pour les données principales de la météo
struct Main: Codable {
    let temp: Double          // Température en °C
    let humidity: Int         // Pourcentage d'humidité
}

// Structure pour les conditions météo
struct Weather: Codable {
    let description: String   // Description textuelle (ex: "Ensoleillé")
    let icon: String          // Code d'icône fourni par OpenWeather
}
