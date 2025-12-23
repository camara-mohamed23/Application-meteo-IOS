// Enum pour gérer les erreurs réseau de manière claire
enum NetworkError: Error {
    
    // L'URL est invalide ou mal formée
    case badURL
    
    // La réponse du serveur n'est pas valide (ex: code HTTP != 200)
    case invalidResponse
    
    // Impossible de décoder le JSON reçu en struct Swift
    case decodingError
}
