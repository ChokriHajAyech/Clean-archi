import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class HousingDetailsViewController: BaseViewController <HousingDetailsCoordinator, HousingDetailsViewModel>,
    MainStoryboardLodable, Storyboarded {

    @IBOutlet var photoSliderView: PhotoSliderView!
    @IBOutlet weak var propertyTypeLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    var identifier: Int?
    let disposeBag =  DisposeBag()

    func configure(coordinator: HousingDetailsCoordinator, identifier: Int) {
        super.configure(coordinator: coordinator)
        self.identifier = identifier
    }

    override func viewDidLoad() {
        bindingInputs()
        bindingOutputs()
        photoSliderView.flush()
    }

    // MARK: View Methods

    func bindingInputs() {
        guard let identifier = self.identifier else {
            return
        }
        viewModel.input.identifier.onNext(identifier)
    }

    private func bindingOutputs() {

        viewModel.output.housing.map({ housing -> String? in
            return housing?.propertyType
        }).drive( self.propertyTypeLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.output.housing.map({ housing -> String? in
            return "\(housing?.area ?? 0)"
        }).drive( self.areaLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.output.housing.map({ housing -> String? in
            return "\(housing?.price ?? 0)"
        }).drive( self.priceLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.output.housing.map({ housing -> String? in
            return housing?.city
        }).drive( self.cityLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.output.housing.map({ housing -> String? in
            return housing?.city
        }).drive( self.cityLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.output.housing.drive(onNext: { [self] housing in
            try? UIImageView()
                .downloadImage(
                    url: housing?.image,
                    placeHolder: #imageLiteral(resourceName: "imagePlaceholder"),
                    completion: { [self] image in
                        if let image = image {
                            let images: [UIImage] =
                                [image,
                                 UIImage(named: "imagePlaceholder")!,
                                 UIImage(named: "imagePlaceholder")!,
                                 UIImage(named: "imagePlaceholder")!,
                                 UIImage(named: "imagePlaceholder")!,
                                 UIImage(named: "imagePlaceholder")!]
                            photoSliderView.configure(with: images)
                        }
                    })

        }).disposed(by: disposeBag)
    }
}
