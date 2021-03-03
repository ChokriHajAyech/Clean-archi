import UIKit
import RxSwift
import RxCocoa

// MARK: - IBOutlet

class HomeViewController: BaseViewController<HomeCoordinator, HomeViewModel>,
                          Storyboarded, MainStoryboardLodable {
    let disposBag = DisposeBag()

    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

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
        searchBar.rx.text
            .orEmpty
            .observeOn(MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.input.search)
            .disposed(by: disposBag)

        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        viewWillAppear.drive(viewModel.input.trigger).disposed(by: disposBag)

        viewModel
            .rxOffers
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx
                    .items(cellIdentifier: HomeCell.identifier,
                           cellType: HomeCell.self)) { _, housing, cell in
                (cell as HomeCell).bind(housingDataCell: housing)
                (cell as HomeCell).bind(to: self.viewModel)
                cell.refreshCallBack = {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
            }.disposed(by: disposBag)

        tableView.rx.modelSelected(HousingList.self)
            .subscribe(onNext: { item in self.viewModel
                .displayHousingDetails(identifier: item.identifier ?? -1)
            }).disposed(by: disposBag)

        /* tableView.rx.modelSelected(HousingList.self)
         .subscribe(onNext: { item in self.viewModel
         .displayHousingDetails(identifier: item.identifier ?? -1)
         }).disposed(by: disposBag)
         
         viewModel.output.housingListDataCell
         .drive(tableView.rx
         .items(cellIdentifier: HomeCell.identifier,
         cellType: HomeCell.self)) { row, housing, cell in
         (cell as HomeCell).bind(housingDataCell: housing)
         (cell as HomeCell).bind(to: self.viewModel)
         cell.refreshCallBack = {
         self.tableView.beginUpdates()
         self.tableView.endUpdates()
         }
         }.disposed(by: disposBag)*/

    }
}
