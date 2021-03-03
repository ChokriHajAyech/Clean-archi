import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct HousingListCoredataModel {

    var identifier: Int
    var propertyType: String
    var area: Float
    var price: Float
    var city: String
    var urlImage: String

    init(housing: HousingList) {
        self.identifier = housing.identifier ?? 0
        self.propertyType = housing.propertyType ?? ""
        self.area = housing.area ?? 0.0
        self.price = housing.price ?? 0.0
        self.city = housing.city  ?? ""
        self.urlImage = housing.urlImage  ?? ""
    }
}

func == (lhs: HousingListCoredataModel, rhs: HousingListCoredataModel) -> Bool {
    return lhs.identifier == rhs.identifier
}

extension HousingListCoredataModel: Equatable { }

extension HousingListCoredataModel: IdentifiableType {
    typealias Identity = String
    var identity: Identity { return "\(identifier)" }
}

extension HousingListCoredataModel: Persistable {

    typealias TMO = NSManagedObject

    static var entityName: String {
        return "HousingListCoredataModel"
    }

    static var primaryAttributeName: String {
        return "identifier"
    }

    init(entity: TMO) {
        identifier = entity.value(forKey: "identifier") as? Int ?? -1
        propertyType = entity.value(forKey: "propertyType") as? String ?? "NA"
        area = entity.value(forKey: "area") as? Float ?? -1
        price = entity.value(forKey: "price")as? Float ?? -1
        city = entity.value(forKey: "city") as? String ?? "NA"
        urlImage = entity.value(forKey: "urlImage") as? String ?? "NA"
    }

    func update(_ entity: TMO) {
        entity.setValue(identifier, forKey: "identifier")
        entity.setValue(propertyType, forKey: "propertyType")
        entity.setValue(area, forKey: "area")
        entity.setValue(price, forKey: "price")
        entity.setValue(city, forKey: "city")
        entity.setValue(urlImage, forKey: "urlImage")
        do {
            try entity.managedObjectContext?.save()
        } catch let error {
            print(error)
        }
    }

}
