//
//  AccorlexMenuSection.swift
//  Accorlex
//
//  Created by Barış Uyar on 3.04.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import Foundation

public protocol AccorlexConfigurableCell: NibLoadableView, ReusableView {
    associatedtype DataType
    func configure(data: DataType)
}

public protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    func register(tableView: AccorlexTableView)
}

public struct AccorlexCellConfigurator<CellType: AccorlexConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    public static var reuseId: String { return String(describing: CellType.self) }
    
    let item: DataType
    
    public init(item: DataType) {
        self.item = item
    }
    
    public func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
    
    public func register(tableView: AccorlexTableView) {
        tableView.register(CellType.self)
    }
}

public protocol SectionConfigurator {
    var configurators: Array<CellConfigurator> { get set }
    var headerConfigurator: CellConfigurator { get set }
    var isOpen: Bool { get set }
    func didSelect(cellConfigurator: CellConfigurator)
    func didHeaderSelect(cellConfigurator: CellConfigurator)
}

public struct AccorlexSectionConfigurator<CellType: AccorlexConfigurableCell, HeaderCellType: AccorlexConfigurableCell, CellDataType, HeaderDataType>:
    SectionConfigurator where CellType.DataType == CellDataType, CellType: UITableViewCell,
HeaderCellType.DataType == HeaderDataType, HeaderCellType: UITableViewCell {
    public var configurators: Array<CellConfigurator>
    public var headerConfigurator: CellConfigurator
    public var isOpen: Bool = true
    
    var didSelect: ((_ selected: CellDataType) -> ())?
    var didHeaderSelect: ((_ selected: HeaderDataType) -> ())?
    
    public init(cellItems: Array<CellDataType>, headerItem: HeaderDataType,_ didSelect: ((_ selected: CellDataType) -> ())?,_ didHeaderSelect: ((_ selected: HeaderDataType) -> ())?) {
        self.configurators = Array<AccorlexCellConfigurator<CellType, CellDataType>>()
        for item in cellItems {
            configurators.append(AccorlexCellConfigurator<CellType, CellDataType>(item: item))
        }
        self.headerConfigurator = AccorlexCellConfigurator<HeaderCellType, HeaderDataType>(item: headerItem)
        self.didSelect = didSelect
        self.didHeaderSelect = didHeaderSelect
    }
    
    public func didSelect(cellConfigurator: CellConfigurator) {
        guard let configurator = cellConfigurator as? AccorlexCellConfigurator<CellType, CellDataType> else { return }
        didSelect?(configurator.item)
    }
    
    public func didHeaderSelect(cellConfigurator: CellConfigurator) {
        guard let configurator = cellConfigurator as? AccorlexCellConfigurator<HeaderCellType, HeaderDataType> else { return }
        didHeaderSelect?(configurator.item)
    }
}

public struct AccorlexViewModel {
    
    var sections: Array<SectionConfigurator>
    
    public init(sections: Array<SectionConfigurator>) {
        self.sections = sections
    }
}
