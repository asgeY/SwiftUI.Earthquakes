import SwiftUI

struct ContentView : View {
    
    @State var networkManager = NetworkingManager()
    
    var body: some View {
        List(networkManager.earthquakes.features.identified(by: \.geometry)) { earthquake in
            CellRow(data: earthquake)
        }
    }
}


struct CellRow: View {
    var data: Feature
    
    var body: some View {
        HStack(alignment: .center, spacing: 9) {
            VStack(alignment: .leading) {
                VStack {
                    Text(String(data.properties.mag))
                        .bold()
                        .color(.white)
                        .font(.headline)
                }.frame(width: 100, height: 100)
                    .background(Color.green)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 10)
            }
            
            VStack(alignment: .leading) {
                Text(data.properties.place)
                Text("Time: \(self.timeConverter(timeStamp: data.properties.time))")
            }
        }
    }
    
    
    func timeConverter(timeStamp: Double) -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = NSLocale.current
        df.dateFormat = "dd MMM YY, hh:mm a"
        
        let date = Date(timeIntervalSince1970: timeStamp/1000 )
        return df.string(from: date)
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
