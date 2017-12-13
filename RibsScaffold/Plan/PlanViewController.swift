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
    func refreshPlan()
    func addPlan(title: String)
    func updatePlan(plan: Plan)
}

let CellIdentifier = "PlanUITableViewCell"

final class PlanViewController: UIViewController, PlanViewControllable {
    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }
    var viewModel: PlanTableViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Plan", image: nil, tag: 1)
        title = "Plans"
        setupNavBar()
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
    func reloadData() {
        tableView.reloadData()
        setLoading(active: false)
    }
    
    func setLoading(active: Bool) {
        if active {
            self.view.activityIndicatorView.startAnimating()
        } else {
            self.view.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK : - Private
    private let refreshControl = UIRefreshControl()
    
    private lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero)
    }()
    
    private func setupNavBar() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didTapAddButton(sender:)))

        navigationItem.rightBarButtonItems = [addButton]
    }
    
    @objc private func didTapAddButton(sender: AnyObject) {
        let alert = UIAlertController(title: "New Plan",
                                      message: "Add a Plan",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
            let textField = alert.textFields![0]
            self.viewModel?.addPlan(title: textField.text!)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
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
        tableView.estimatedRowHeight = 50
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPlan(_:)), for: .valueChanged)
    }
    
    @objc private func refreshPlan(_ sender: Any) {
        viewModel?.refreshPlan()
    }
}

extension PlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel?.dataSource?.count {
            return count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! PlanTableViewCell
        if let planViewModel = viewModel?.dataSource?[indexPath.row] {
            cell.viewModel = planViewModel
        }
        return cell
    }
}

