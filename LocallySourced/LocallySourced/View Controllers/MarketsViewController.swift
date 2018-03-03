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
    
    lazy var detailView = DetailView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.detailView.backgroundColor = .green
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

