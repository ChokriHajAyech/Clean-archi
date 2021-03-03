import Foundation

public enum ApiResult<Value, Error> {
    case success(Value)
    case failure(Error)
    init(value: Value) {
        self = .success(value)
    }
    init(error: Error) {
        self = .failure(error)
    }
}
