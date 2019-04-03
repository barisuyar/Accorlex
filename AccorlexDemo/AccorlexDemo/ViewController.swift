//
//  ViewController.swift
//  AccorlexDemo
//
//  Created by Barış Uyar on 3.04.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit
import Accorlex

public typealias MySectionConfigurator = AccorlexSectionConfigurator<NormalCell, SectionCell, NormalCellModel, SectionCellModel>

class ViewController: UIViewController {

    @IBOutlet weak var accorlexTableView: AccorlexTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }

    func configure() {
        var colorArray: [UIColor] = [.white, .red, .orange, .yellow, .blue]
        
        let section1Model = SectionCellModel(label: "Birinci Section")
        
        var section1Cells: [NormalCellModel] = []
        for i in (0...5) {
            let section1Cell = NormalCellModel(topLabel: "Birinci Section \(i). cell", bottomLabel: "Deneme", color: colorArray[i % (colorArray.count - 1)])
            section1Cells.append(section1Cell)
        }
        
        let section1 = MySectionConfigurator(cellItems: section1Cells, headerItem: section1Model, { selected in
            print(selected.topLabel)
        }, nil)
        
        let section2Model = SectionCellModel(label: "İkinci Section")
        
        var section2Cells: [NormalCellModel] = []
        for i in (0...6) {
            let section2Cell = NormalCellModel(topLabel: "İkinci Section \(i). cell", bottomLabel: "Deneme", color: colorArray[i % (colorArray.count - 1)])
            section2Cells.append(section2Cell)
        }
        
        let section2 = MySectionConfigurator(cellItems: section2Cells, headerItem: section2Model, {
            selected in
            print(selected)
        }) { headerSelected in
            print(headerSelected.label)
        }
        
        let accorlexViewModel = AccorlexViewModel(sections: [section1, section2])
        
        accorlexTableView.accorlexViewModel = accorlexViewModel
        accorlexTableView.reloadData()
    }

}

