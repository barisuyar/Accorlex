//
//  AccorlexTableView.swift
//  Accorlex
//
//  Created by Barış Uyar on 3.04.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import Foundation

public class AccorlexTableView: UITableView {
    
    public var accorlexViewModel: AccorlexViewModel? {
        didSet {
            if let viewModel = accorlexViewModel {
                for section in viewModel.sections {
                    section.headerConfigurator.register(tableView: self)
                    section.configurators.first?.register(tableView: self)
                }
            }
        }
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        tableFooterView = UIView(frame: .zero)
        separatorStyle = .none
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
    }
}

extension AccorlexTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let viewModel = accorlexViewModel, viewModel.sections.count > indexPath.section else { return nil }
        if indexPath.row == 0 {
            let indexPathList = (1...viewModel.sections[indexPath.section].configurators.count).map { IndexPath(row: $0, section: indexPath.section) }
            if viewModel.sections[indexPath.section].isOpen {
                accorlexViewModel?.sections[indexPath.section].isOpen = false
                tableView.deleteRows(at: indexPathList, with: .none)
            } else {
                accorlexViewModel?.sections[indexPath.section].isOpen = true
                tableView.insertRows(at: indexPathList, with: .none)
            }
            return indexPath
        }
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = accorlexViewModel, viewModel.sections.count > indexPath.section else { return }
        if indexPath.row != 0 {
            let cell = viewModel.sections[indexPath.section].configurators[indexPath.row - 1]
            viewModel.sections[indexPath.section].didSelect(cellConfigurator: cell)
        } else {
            let header = viewModel.sections[indexPath.section].headerConfigurator
            viewModel.sections[indexPath.section].didHeaderSelect(cellConfigurator: header)
        }
    }
    
}

extension AccorlexTableView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = accorlexViewModel?.sections.count else { return 0 }
        return count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = accorlexViewModel else { return 0 }
        return viewModel.sections[section].isOpen ? viewModel.sections[section].configurators.count + 1 : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = accorlexViewModel else { return UITableViewCell() }
        for (index, _) in viewModel.sections.enumerated() {
            guard index <= indexPath.section else { return UITableViewCell() }
            switch indexPath.row {
            case 0:
                let headerConfigurator = viewModel.sections[indexPath.section].headerConfigurator
                let reuseId = type(of: headerConfigurator).reuseId
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)!
                cell.selectionStyle = .none
                headerConfigurator.configure(cell: cell)
                return cell
            default:
                let configurator = viewModel.sections[indexPath.section].configurators[indexPath.row - 1]
                let reuseId = type(of: configurator).reuseId
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)!
                cell.selectionStyle = .none
                configurator.configure(cell: cell)
                return cell
            }
        }
        return UITableViewCell()
    }
}
