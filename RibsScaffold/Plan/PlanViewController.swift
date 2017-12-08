//
//  PlanViewController.swift
//  RibsScaffold
//
//  Created by Kevin Mun on 07/12/2017.
//  Copyright © 2017 kev. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol PlanPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

let CellIdentifier = "PlanUITableViewCell"

final class PlanViewController: UIViewController, PlanPresentable, PlanViewControllable {
    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: PlanPresentableListener?
    
    var dataSource: [Plan]?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Plan", image: nil, tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
        setLoading(active: true)
    }
    
    // Mark : - PlanPresentable
    func updateSource(plans: [Plan]) {
        dataSource = plans
        tableView.reloadData()
        setLoading(active: false)
    }
    
    func setLoading(active: Bool) {
        if active {
            view.activityIndicatorView.startAnimating()
        } else {
            view.activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK : - Private
    private lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero)
    }()
    
    private func buildTableView() {
        tableView.backgroundColor = UIColor.SystemGray
        tableView.dataSource = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
}

extension PlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = dataSource?.count {
            return count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! PlanTableViewCell
        if let plan = dataSource?[indexPath.row] {
            cell.mainLabel.text = plan.title
        }
        return cell
    }
}

