import UIKit

enum TabBarPageEnum {
	case home
	case favorites
	case settings

	init?(index: Int) {
		switch index {
		case 0:
			self = .home
		case 1:
			self = .favorites
		case 2:
			self = .settings
		default:
			return nil
		}
	}

	func pageTitleValue() -> String {
		switch self {
		case .home:
			return "Accueil"
		case .favorites:
			return "Favoris"
		case .settings:
			return "Paramètres"
		}
	}

	func pageImageIcon() -> UIImage {
		switch self {
		case .home:
			return #imageLiteral(resourceName: "ic_home")
		case .favorites:
			return #imageLiteral(resourceName: "ic_favorite_off")
		case .settings:
			return #imageLiteral(resourceName: "ic_settings")
		}
	}

	func pageOrderNumber() -> Int {
		switch self {
		case .home:
			return 0
		case .favorites:
			return 1
		case .settings:
			return 2
		}
	}
}
