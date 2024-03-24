import Foundation
import LEGOKit
import LWPKit

enum CurrentDirection {
    case forward
    case backward
    case left
    case right
}

@MainActor
class Car {
    var hub: Hub
    var speed: Float = 0 {
        didSet {
            if let direction {
                switch direction {
                case .forward:
                    runForward()
                case .backward:
                    runBackward()
                case .left:
                    runLeft()
                case .right:
                    runRight()
                }
            }
        }
    }
    var rawSpeed: Int8 {
        Int8(speed * 50)
    }
    var direction: CurrentDirection?
    
    init(hub: Hub) {
        self.hub = hub
    }
    
    @MainActor
    func runForward() {
        let power0 = try! StartPower(portID: 0, power: -rawSpeed).data()
        let power1 = try! StartPower(portID: 1, power: rawSpeed).data()
        
        hub.write(power0)
        hub.write(power1)
        self.direction = .forward
    }
    
    @MainActor
    func runBackward() {
        let power0 = try! StartPower(portID: 0, power: rawSpeed).data()
        let power1 = try! StartPower(portID: 1, power: -rawSpeed).data()
        
        hub.write(power0)
        hub.write(power1)
        self.direction = .backward
    }
    
    @MainActor
    func runLeft() {
        let power0 = try! StartPower(portID: 0, power: rawSpeed).data()
        let power1 = try! StartPower(portID: 1, power: rawSpeed).data()
        
        hub.write(power0)
        hub.write(power1)
        self.direction = .left
    }
    
    @MainActor
    func runRight() {
        let power0 = try! StartPower(portID: 0, power: -rawSpeed).data()
        let power1 = try! StartPower(portID: 1, power: -rawSpeed).data()
        
        hub.write(power0)
        hub.write(power1)
        self.direction = .right
    }
}
