import Foundation

final class HousingDataCellMapper: Mapper {
typealias InputEntity = HousingDetails
typealias OutputEntity = HousingList

func mapFromEntity(type: HousingDetails) -> HousingList? {
return .init(identifier: type.identifier,
 propertyType: type.propertyType, area: type.area,
 price: type.price, city: type.city,
 urlImage: type.image, isSelected: false)
}

func mapToEntity(type: HousingList) -> HousingDetails? {
return nil
}
}
