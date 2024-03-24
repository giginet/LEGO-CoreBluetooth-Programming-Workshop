import Foundation
import LEGOKit

extension Hub {
    func run(_ action: Action) {
        if let hexData = action.hexData {
            self.write(hexData)
        }
    }
}
