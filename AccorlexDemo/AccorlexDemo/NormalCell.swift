//
//  NormalCell.swift
//  AccorlexDemo
//
//  Created by Barış Uyar on 3.04.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit
import Accorlex

public struct NormalCellModel {
    var topLabel: String?
    var bottomLabel: String?
    var color: UIColor?
}

public typealias NormalCellConfig = AccorlexCellConfigurator<NormalCell, NormalCellModel>

public class NormalCell: UITableViewCell, AccorlexConfigurableCell {

    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(data: NormalCellModel) {
        topLabel.text = data.topLabel
        bottomLabel.text = data.bottomLabel
        contentView.backgroundColor = data.color
    }
}
