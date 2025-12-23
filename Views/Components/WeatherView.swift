import SwiftUI

struct WeatherView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 10) {
            Text(weather.name)
                .font(.largeTitle)
                .bold()
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            
            Text("\(Int(weather.main.temp))°C")
                .font(.system(size: 60))
                .bold()
                .foregroundStyle(.linearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
            
            Text(weather.weather.first?.description.capitalized ?? "")
                .font(.headline)
            
            Text("Humidité: \(weather.main.humidity)%")
                .font(.caption)
        }
        .padding()
        .background(LinearGradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
    }
}
