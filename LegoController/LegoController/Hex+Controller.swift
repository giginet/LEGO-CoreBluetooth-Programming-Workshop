import Foundation
import LEGOKit

extension Hub {
    func run(_ action: Action) {
        if let hexData = action.hexData {
            print("sending: \(action.hexString)")
            self.write(hexData)
        }
    }
}
