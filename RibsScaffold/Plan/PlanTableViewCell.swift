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
    var viewModel: PlanTableCellViewModel? {
        didSet {
            invalidateView()
        }
    }
    
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
        subContentView.addSubview(checkBox)
        subContentView.addSubview(mainLabel)
        subContentView.backgroundColor = UIColor.white
        subContentView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.edges.equalTo(contentView).inset(UIEdgeInsetsMake(5, 5, 5, 5))
        }
        mainLabel.snp.makeConstraints{(maker: ConstraintMaker) in
            maker.left.equalTo(subContentView).offset(15)
            maker.right.equalTo(checkBox).offset(-5)
            maker.top.equalTo(subContentView).offset(5)
            maker.bottom.equalTo(subContentView).offset(-5)
        }
        mainLabel.lineBreakMode = .byTruncatingTail
        mainLabel.numberOfLines = 3
        mainLabel.textColor = UIColor.white
        
        subContentView.layer.cornerRadius = 3
        subContentView.layer.shadowOffset = CGSize.zero
        subContentView.layer.shadowOpacity = 1
        subContentView.layer.shadowColor = UIColor.black.cgColor
        subContentView.layer.shadowRadius = 2
        
        checkBox.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        checkBox.setBackgroundImage(UIImage(named: "checked"), for: .selected)
        checkBox.addTarget(self, action: #selector(clickBox(sender:)), for: .touchDown)
        checkBox.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.right.equalTo(subContentView).offset(-15)
            maker.width.equalTo(20)
            maker.height.equalTo(20)
            maker.centerY.equalTo(subContentView)
        }
        
    }
    
    private func invalidateView() {
        guard let viewModel = viewModel else {
            return
        }
        mainLabel.text = viewModel.planTitle
        checkBox.isSelected = viewModel.completed
        if let planType = viewModel.planType {
            var color: UIColor?
            switch(planType) {
            case .Important:
                color = UIColor.red
                break;
            case .SemiImportant:
                color = UIColor.purple
                break;
            case .Normal:
                color = UIColor.blue
                break;
            case .Trivial:
                color = UIColor.green
                break;
            }
            subContentView.backgroundColor = color
        }
    }
    
    
   @objc private func clickBox(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel?.updateCompleted(completed: sender.isSelected)
    }
    
    private lazy var subContentView: UIView = {
       return UIView(frame: CGRect.zero)
    }()
    
    lazy var mainLabel: UILabel = {
        return UILabel(frame: CGRect.zero)
    }()
    
    lazy var checkBox: UIButton = {
        return UIButton(frame: CGRect.zero)
    }()
}
