import Foundation

enum Direction {
    case clockwise
    case anticlockwise
}

enum Action {
    case moveLeftMotor(Float)
    case moveRightMotor(Float)
    
    var hexString: String {
        switch self {
        case .moveLeftMotor(let power):
            "08 00 81 00 11 51 00 \(power.hexString)" // clockwise
        case .moveRightMotor(let power):
            "08 00 81 01 11 51 00 \(power.hexString)"
        }
    }
}

extension Action {
    var hexData: Data? {
        Data(hexString: hexString)
    }
}

extension Float {
    func clamped(to range: ClosedRange<Float>) -> Float {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

extension Float {
    var hexString: String {
        String(Int(floor(self * 64)))
    }
}
