import SwiftUI
import LEGOKit

struct ContentView: View {
    @StateObject var hub = Hub()
    @State var hexString = "08 00 81 00 11 51 00 32"
    
    var body: some View {
        VStack {
            HStack {
                if hub.isReady {
                    Text(hub.connectingPeripheral?.name ?? "No name")
                    Button {
                        hub.disconnect()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else if hub.isConnecting {
                    Text("Connecting...")
                    Button {
                        hub.cancelConnecting()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    Button("Connect") {
                        hub.connect()
                    }
                }
            }
            
            HStack {
                TextField("Hex Data", text: $hexString)
                    .padding(4)
                    .border(.tint, width: 1)
                Button("Write") {
                    if let data = Data(hexString: hexString) {
                        hub.write(data)
                    }
                }
                .disabled(!hub.isReady)
            }
        }
        .padding()
    }
}
