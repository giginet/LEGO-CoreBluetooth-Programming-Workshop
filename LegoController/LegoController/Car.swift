import Foundation
import LEGOKit
import LWPKit

struct Car {
    var hub: Hub
    var speed: Float = 50
    
    init(hub: Hub) {
        self.hub = hub
    }
    
    @MainActor
    func runForward() {
        let power0 = try! StartPower(portID: 0, power: -50).data()
        let power1 = try! StartPower(portID: 1, power: 50).data()
        
        hub.write(power0)
        hub.write(power1)
    }
    
    @MainActor
    func runBackward() {
        let power0 = try! StartPower(portID: 0, power: 50).data()
        let power1 = try! StartPower(portID: 1, power: -50).data()
        
        hub.write(power0)
        hub.write(power1)
    }
    
    @MainActor
    func runLeft() {
        let power0 = try! StartPower(portID: 0, power: 50).data()
        let power1 = try! StartPower(portID: 1, power: 50).data()
        
        hub.write(power0)
        hub.write(power1)
    }
    
    @MainActor
    func runRight() {
        let power0 = try! StartPower(portID: 0, power: -50).data()
        let power1 = try! StartPower(portID: 1, power: -50).data()
        
        hub.write(power0)
        hub.write(power1)
    }
}
