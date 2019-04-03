//
//  SectionCell.swift
//  AccorlexDemo
//
//  Created by Barış Uyar on 3.04.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit
import Accorlex

public struct SectionCellModel {
    var label: String?
}

public typealias SectionCellConfig = AccorlexCellConfigurator<SectionCell, SectionCellModel>

public class SectionCell: UITableViewCell, AccorlexConfigurableCell {

    @IBOutlet weak var label: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(data: SectionCellModel) {
        label.text = data.label
    }
}
