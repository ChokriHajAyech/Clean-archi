import Foundation

final class HousingMapper: Mapper {
    typealias InputEntity = HousingDetails
    typealias OutputEntity = HousingModel

    func mapFromEntity(type: HousingDetails) -> HousingModel? {
        return nil
    }

    func mapToEntity(type: HousingModel) -> HousingDetails? {
        return .init(identifier: type.identifier, bedrooms: type.bedrooms,
                     city: type.city, area: type.area, image: type.url,
                     price: type.price, propertyType: type.propertyType,
                     rooms: type.rooms)
    }
}
