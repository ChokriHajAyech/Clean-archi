import Foundation
import UIKit
import RxCocoa
import RxSwift

class FavorisViewController: BaseViewController<FavorisCoordinator, FavoritesViewModel>,
    Storyboarded, MainStoryboardLodable {

    let disposBag = DisposeBag()

  // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
    }

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: HomeCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HomeCell.identifier)
    }

    func bind() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        viewWillAppear.drive(viewModel.input.trigger)
            .disposed(by: disposBag)

        viewModel.output.reload.asObservable().subscribe { _ in
            self.tableView.reloadData()
        }.disposed(by: disposBag)

        viewModel.output
            .housingListDataCell
            .drive(tableView.rx.items(
                    cellIdentifier: HomeCell.identifier,
                    cellType: HomeCell.self)) { _, housing, cell in
                (cell as HomeCell).bind(housingDataCell: housing)
                //(cell as HomeCell).bind(to: self.viewModel)
                cell.refreshCallBack = {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
            }.disposed(by: disposBag)
    }
}
