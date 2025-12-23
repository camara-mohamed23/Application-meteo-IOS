import Foundation // Import nécessaire pour URLSession, Codable, etc.

// Service pour récupérer les données météo depuis l'API OpenWeather
class WeatherAPIService {
    
    // Singleton pour accéder facilement au service
    static let shared = WeatherAPIService()
    
    // Constructeur privé pour forcer l'utilisation du singleton
    private init() {}

    // Fonction pour récupérer la météo actuelle d'une ville
    func fetchWeather(city: String) async throws -> WeatherResponse {
        // Encode le nom de la ville pour l'URL (ex: espaces → %20)
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        // Crée l'URL complète avec la clé API, unité métrique et langue française
        let urlString = "\(Constants.baseURL)/weather?q=\(cityEncoded)&units=metric&lang=fr&appid=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }

        // Appel réseau asynchrone
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Vérifie que la réponse HTTP est valide
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        // Décode le JSON reçu en struct WeatherResponse
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }

    // Fonction pour récupérer les prévisions météo d'une ville (forecast)
    func fetchForecast(city: String) async throws -> ForecastResponse {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        let urlString = "\(Constants.baseURL)/forecast?q=\(cityEncoded)&units=metric&lang=fr&appid=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        // Décode le JSON reçu en struct ForecastResponse
        return try JSONDecoder().decode(ForecastResponse.self, from: data)
    }
}
