//
//  ViewController.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

class MarketsViewController: UIViewController {
    
    let marketView = MarketsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        constrainView()
    }

    private func constrainView() {
        view.addSubview(marketView)
        marketView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}

