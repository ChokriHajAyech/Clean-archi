import UIKit
import RxSwift
import RxCocoa

import SDWebImage

class HomeCell: UITableViewCell, HomeViewModelBindable {

    static let identifier = "HomeCell"
    @IBOutlet weak var housingImageView: SDAnimatedImageView!
    @IBOutlet weak var propertyTypeLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var container: RoundShadowView!
    @IBOutlet weak var favoriteButton: FloatingActionButton!
    var disposeBag: DisposeBag?
    var refreshCallBack: (() -> Void)?
    var identifier: Int?
    var current: HousingList?
    var viewModel: HomeViewModel!

    internal var aspectConstraint: NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                housingImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                housingImageView.addConstraint(aspectConstraint!)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
        disposeBag = nil
        current = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.aspectConstraint = nil
        self.propertyTypeLabel.text = nil
        self.areaLabel.text = nil
        self.priceLabel.text = nil
        self.cityLabel.text = nil
        self.housingImageView.image = nil
        self.favoriteButton.isSelected = false
    }

    func bind(to viewModel: HomeViewModel) {
        disposeBag = DisposeBag()
        favoriteButton.rx
            .tap.map { _ -> Int in
                return self.identifier!
            }.bind(to: viewModel.input.validate)
            .disposed(by: disposeBag!)
    }

    func bind(housingDataCell: HousingList) {
        current = housingDataCell
        self.favoriteButton.isSelected = housingDataCell.isSelected!
        self.identifier = housingDataCell.identifier
        self.propertyTypeLabel.text = housingDataCell.propertyType
        self.areaLabel.text = "\(housingDataCell.area ?? 0)"
        self.priceLabel.text = "\(housingDataCell.price ?? 0)"
        self.cityLabel.text = housingDataCell.city
        try? self.housingImageView
            .downloadImage(url: housingDataCell
                            .urlImage, placeHolder: #imageLiteral(resourceName: "imagePlaceholder"),
                           completion: { [self] image in
                            if let image = image {
                                setCustomImage(image: image)
                            }})
    }

    func setCustomImage(image: UIImage) {
        let aspect = image.size.width / image.size.height
        let constraint = NSLayoutConstraint(
            item: housingImageView!,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: housingImageView,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        self.aspectConstraint = constraint
        self.housingImageView.image = image
        self.refreshCallBack?()
    }
}
