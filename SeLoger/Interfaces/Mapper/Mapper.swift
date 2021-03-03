import Foundation

protocol Mapper {
    associatedtype InputEntity
    associatedtype OutputEntity
    func mapFromEntity(type: InputEntity) -> OutputEntity?
    func mapToEntity(type: OutputEntity) -> InputEntity?
}
