//
//  ListTableViewAdapter.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import UIKit

final class ListTableViewAdapter: NSObject  {
    
    typealias Item = CityViewModel
    
    // MARK: - Private properties
    private var dataSource: [Item] = []
    private let tableView: UITableView?
    
    // MARK: - Life cycle
    init(tableView: UITableView?) {
        self.tableView = tableView
        
        super.init()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: String(describing: CityCell.self), bundle: nil),
                            forCellReuseIdentifier: String(describing: CityCell.self))
    }
    
    // MARK: - Public method
    func update(_ model: [Item]) {
        self.dataSource = model
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCell.self), for: indexPath) as? CityCell else { return UITableViewCell() }
        cell.model = dataSource[indexPath.row]
        return cell
    }
}
