import Foundation
final class HousingListDAOMapper: Mapper {

    typealias InputEntity = HousingList
    typealias OutputEntity = HousingListCoredataModel

    func mapFromEntity(type: HousingList) -> HousingListCoredataModel? {
        return nil
    }

    func mapToEntity(type: HousingListCoredataModel) -> HousingList? {
       .init(identifier: type.identifier, propertyType: type.propertyType,
             area: type.area, price: type.price, city: type.city,
             urlImage: type.urlImage, isSelected: true)
    }

    func mapFromEntity(type: HousingDetails) -> HousingModel? {
        return nil
    }

}
