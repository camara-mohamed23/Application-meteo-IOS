import SwiftUI

struct ForecastView: View {
    let forecast: ForecastResponse

    var body: some View {
        VStack(alignment: .leading) {
            Text("Prévisions")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(forecast.list.prefix(5)) { item in
                        VStack(spacing: 8) {
                            Text(item.dt_txt.prefix(10))
                                .font(.caption)
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(item.weather.first?.icon ?? "01d")@2x.png")) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            
                            Text("\(Int(item.main.temp))°C")
                                .bold()
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(16)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}
