import SwiftUI
import LEGOKit

struct ContentView: View {
    @StateObject var hub = Hub()
    @State var hexString = "08 00 81 00 11 51 00 32"

    @State var speed: Float = 0.0
    var body: some View {
        VStack {
            Text("Direction")
            HStack{
                Button{

                }label:{
                    Label("Turn Left", systemImage: "arrowshape.left.fill")
                        .font(.largeTitle)
                        .labelStyle(.iconOnly)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.thickMaterial)
                        .clipShape(Circle())
                }
                Button{

                }label:{
                    Label("ahead", systemImage: "arrowshape.up.fill")
                        .font(.largeTitle)
                        .labelStyle(.iconOnly)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.thickMaterial)
                        .clipShape(Circle())
                }
                Button{

                }label:{
                    Label("Turn Right", systemImage: "arrowshape.right.fill")
                        .font(.largeTitle)
                        .labelStyle(.iconOnly)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.thickMaterial)
                        .clipShape(Circle())
                }
            }

            Text("Speed")
            HStack{
                Button{
                    speed = 0
                }label: {
                    Label("Stop", systemImage: "exclamationmark.octagon.fill")
                        .frame(maxHeight: .infinity)
                        .padding()
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Button{
                    speed = 0.25
                }label: {
                    Label("25% Speed", systemImage: "gauge.with.dots.needle.33percent")
                        .frame(maxHeight: .infinity)
                        .padding()
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.frame(maxHeight: .infinity)
                Button{
                    speed = 0.5
                }label: {
                    Label("50% Speed", systemImage: "gauge.with.dots.needle.50percent")
                        .frame(maxHeight: .infinity)
                        .padding()
                        .background(.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.frame(maxHeight: .infinity)
                Button{
                    speed = 0.75
                }label: {
                    Label("75% Speed", systemImage: "gauge.with.dots.needle.67percent")
                        .frame(maxHeight: .infinity)
                        .padding()
                        .background(.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.frame(maxHeight: .infinity)
                Button{
                    speed = 1
                }label: {
                    Label("100% Speed", systemImage: "gauge.with.dots.needle.100percent")
                        .frame(maxHeight: .infinity)
                        .padding()
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.frame(maxHeight: .infinity)

            }.font(.title)
                .foregroundStyle(.white)
                .labelStyle(.iconOnly)
                .fixedSize(horizontal: false, vertical: true)

            Divider()
                .padding()
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
            }.buttonStyle(.bordered)

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
