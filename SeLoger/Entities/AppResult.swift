import Foundation
public enum AppResult<Value, Error> {

    case success(Value)
    case failure(Error)
    init(value: Value) {
        self = .success(value)
    }
    init(error: Error) {
        self = .failure(error)
    }
    var value: Any? {
        switch self {
        case .success(let data): return data
        case .failure(let err): return err
        }
    }
}
