//
//  PlanTableViewCell.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import UIKit
import SnapKit

class PlanTableViewCell: UITableViewCell {
    static let Height: CGFloat = 100
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK : - Private
    private func buildView() {
        contentView.backgroundColor = UIColor.SystemGray
        contentView.addSubview(subContentView)
        subContentView.backgroundColor = UIColor.white
        subContentView.addSubview(mainLabel)
        subContentView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.edges.equalTo(contentView).inset(UIEdgeInsetsMake(5, 5, 5, 5))
        }
        mainLabel.snp.makeConstraints{(maker: ConstraintMaker) in
            maker.left.equalTo(subContentView).offset(15)
            maker.right.equalTo(subContentView).offset(-15)
            maker.top.equalTo(subContentView).offset(5)
            maker.bottom.equalTo(subContentView).offset(-5)
        }
        
        subContentView.layer.cornerRadius = 3
        subContentView.layer.shadowOffset = CGSize.zero
        subContentView.layer.shadowOpacity = 1
        subContentView.layer.shadowColor = UIColor.black.cgColor
        subContentView.layer.shadowRadius = 2
    }
    
    private lazy var subContentView: UIView = {
       return UIView(frame: CGRect.zero)
    }()
    
    lazy var mainLabel: UILabel = {
        return UILabel(frame: CGRect.zero)
    }()
}
