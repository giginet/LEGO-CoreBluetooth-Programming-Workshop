import SwiftUI
import LEGOKit
import LWPKit

struct ContentView: View {
    @StateObject var hub = Hub()
    @State var hexString = "08 00 81 00 11 51 00 32"

    @State var speed: Float = 0.0
    var body: some View {
        VStack {
            Text("Gigis & Lenas Car")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(colors: [.red, .pink, .purple, .blue], startPoint: .leading, endPoint: .trailing))
                .frame(maxWidth: .infinity, alignment: .leading)

            GroupBox(label:
                        Label("Connect to the Car", systemImage: "car.front.waves.down.fill")
            ){
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
                }.buttonStyle(.borderedProminent)
            }

            VStack{
                GroupBox(label:
                            Label("Direction", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                ){
                    HStack{
                        Button{
                            hub.run(.moveLeftMotor(0.5))
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
                            let power0 = try! StartPower(portID: 0, power: 50).data()
                            let power1 = try! StartPower(portID: 1, power: -50).data()

                            hub.write(power0)
                            hub.write(power1)
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
                }

                GroupBox(label:
                            Label("Speed", systemImage: "hare.fill")
                ){
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

                    }.font(.title2)
                        .foregroundStyle(.white)
                        .labelStyle(.iconOnly)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }.frame(maxHeight: .infinity, alignment: .top)

            
            Divider()
                .padding()

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
            }.padding(.bottom)
        }
        .padding()
    }
}
