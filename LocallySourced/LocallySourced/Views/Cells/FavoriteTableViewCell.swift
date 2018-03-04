//
//  FavoriteTableViewCell.swift
//  LocallySourced
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import FoldingCell

class FavoriteTableViewCell:  FoldingCell  {
        //Add your subViews here
    let detailView = DetailView()
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            //configure the cell reusable identifier here
            super.init(style: style, reuseIdentifier: "customCell")
            setupViews()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            //configure your layout here
        }
        private func setupViews() {
            //Add your views setup here
            setupDetailView()
        }
    func setupDetailView(){
        addSubview(detailView)
        detailView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(snp.edges)
        }
    }



}
