//
//  CharactersViewController.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class CharactersViewController: ViewController<CharactersView> {

    var viewModel: CharactersViewModel!

    let dataSource = RxTableViewSectionedReloadDataSource<SectionViewModel<CharacterItemViewModel>>(configureCell: { _, _, _, _ -> UITableViewCell in
        return UITableViewCell()
    })

    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupOutputs()
        setupInputs()
        viewModel.inputs.didLoad.onNext(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

}

extension CharactersViewController {
    private func setupTableView() {
        let identifier = String(describing: CharacterCell.self)
        mainView.tableView.register(CharacterCell.self, forCellReuseIdentifier: identifier)

        dataSource.configureCell = { _, tableView, indexPath, viewModel in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CharacterCell else { return CharacterCell() }
            cell.viewModel = viewModel
            return cell
        }

        mainView.tableView.rx.itemSelected.bind(onNext: { [weak self] indexPath in
            self?.mainView.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)

        mainView.tableView.rx.willDisplayCell.bind(onNext: { [weak self] event in
            if event.indexPath.row == (self?.mainView.tableView.numberOfRows(inSection: 0) ?? 0) - 5 {
                self?.viewModel.loadNextPage.onNext(())
            }
        }).disposed(by: disposeBag)

    }

    private func setupOutputs() {
        viewModel.outputs.dataSource.drive(mainView.tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        viewModel.outputs.showCharactersEmptyStateDriver.drive(onNext: { [weak self] show in
            if show {
                self?.mainView.tableView.tableFooterView = EmptyStateView(frame: .zero)
            } else {
                self?.mainView.tableView.tableFooterView = UIView()
            }
        }).disposed(by: disposeBag)

        viewModel.outputs.showCharactersLoadingStateDriver.drive(onNext: { [weak self] show in
            if show {
                self?.mainView.tableView.tableFooterView = LoadingStateView(size: .init(width: 70, height: 70),text: "Carregando...")
            } else {
                self?.mainView.tableView.tableFooterView = UIView()
            }
        }).disposed(by: disposeBag)

        viewModel.outputs.errorDriver.drive(onNext: { [weak self] error in
            self?.showAlert(text: error)
        }).disposed(by: disposeBag)
    }

    private func setupInputs() {
        mainView.tableView.rx.modelSelected(CharacterItemViewModel.self).map { $0.character }.bind(to: viewModel.inputs.characterSelected).disposed(by: disposeBag)
    }
}
