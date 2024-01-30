//
//  RickMortyViewController.swift
//  RickAndMortyApp
//
//  Created by Mehmet Ozkan on 30.01.2024.
//

import UIKit
import SnapKit

protocol RickMortyOutput {
    func saveDatas(values: [Result]) async -> Void
    func changeLoading(isLoad: Bool)
}

final class RickMortyViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    private lazy var viewodel: IRickMortyViewModel = RickMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewodel.setDelegate(output: self)
        Task {
            await viewodel.fetchAllCharacters()
        }
    }
    
    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = self.view.frame.size.height * 0.2
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Rick and Morty App"
            self.labelTitle.textColor = .orange
            self.indicator.color = .blue
        }
        indicator.startAnimating()
    }
}

extension RickMortyViewController: RickMortyOutput {
    func saveDatas(values: [Result]) async {
        results = values
        tableView.reloadData()
    }
    
    func changeLoading(isLoad: Bool) {
        DispatchQueue.main.async {
            isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }    }
}

extension RickMortyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
}

extension RickMortyViewController {
    
    private func makeTableView() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    private func makeLabel() {
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { (make) in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}
