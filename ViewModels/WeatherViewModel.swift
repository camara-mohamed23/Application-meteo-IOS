import SwiftUI          // Import de SwiftUI pour ObservableObject et @Published
internal import Combine // Import de Combine pour @Published et la liaison avec SwiftUI

// ViewModel pour gérer la récupération et le stockage des données météo
@MainActor
class WeatherViewModel: ObservableObject {
    
    // Données météo actuelles
    @Published var weather: WeatherResponse?
    
    // Prévisions météo
    @Published var forecast: ForecastResponse?
    
    // Indique si la requête est en cours
    @Published var isLoading = false
    
    // Message d'erreur éventuel
    @Published var errorMessage: String?

    // Fonction asynchrone pour charger la météo d'une ville
    func loadWeather(city: String) async {
        isLoading = true          // Active le spinner de chargement
        errorMessage = nil        // Réinitialise l'erreur

        do {
            // Appelle le service API pour récupérer la météo actuelle
            weather = try await WeatherAPIService.shared.fetchWeather(city: city)
            
            // Appelle le service API pour récupérer les prévisions
            forecast = try await WeatherAPIService.shared.fetchForecast(city: city)
        } catch {
            // Si une erreur survient, on stocke un message
            errorMessage = "Impossible de récupérer la météo"
        }

        isLoading = false         // Désactive le spinner de chargement
    }
}
