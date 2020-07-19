//
//  MainViewController.swift
//  TechMahindraTask
//
//  Created by VijayaBhaskar on 18/07/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let tblView : UITableView = {
           let t = UITableView()
           t.showsVerticalScrollIndicator = false
           t.rowHeight = UITableView.automaticDimension
           return t
    }()
    
    let viewModelFacts = FactsViewModel()
    var safearea:UILayoutGuide!
    var refreshControl: UIRefreshControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        safearea = view.layoutMarginsGuide
        setUpUI()
        setUpValues(isLoading: true)
        addRefreshControl()
    }

    //MARK:- ADD REFRESH CONTROLLER
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Loading", comment: "Pull to refresh")
        refreshControl!.attributedTitle = NSAttributedString(string: title)
        refreshControl?.tintColor = UIColor.lightGray
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tblView.addSubview(refreshControl!)
    }
    
    //MARK:- REFRESH CONTROLLER ACTION METHOD
    @objc func refreshList() {
        refreshControl?.endRefreshing()
        setUpValues(isLoading: false)
    }
    //MARK:- UITABLEVIEW CREATIONS
    func setUpUI() {
        self.view.addSubview(tblView)
        if #available(iOS 11.0, *) {
            tblView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            tblView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        }else{
            tblView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            tblView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        }
        tblView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tblView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tblView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 200
        tblView.separatorStyle = .none
        tblView.delegate = self
        tblView.dataSource = self
        tblView.backgroundColor = UIColor.white
        tblView.register(detailsCell.self, forCellReuseIdentifier: TvIdentifierNames.detailsCell)
        
    }
    
    func setUpValues(isLoading:Bool){
        if isLoading{
            //        self.activityIndicatorView = ActivityIndicatorView(title: "Fetching...", center: self.view.center)
            //        self.activityIndicatorView.startAnimating()
        }
        viewModelFacts.fetchData(vc: self) { (isSuccess) in
            if isSuccess{
                DispatchQueue.main.async { // Using GCD to run UI thread concurrantly
                    self.title = self.viewModelFacts.title
                    self.tblView.reloadData()
                }
            }
        }
    }
    
}

// MARK: UITableViewDelegate && UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelFacts.factsDataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvIdentifierNames.detailsCell) as! detailsCell
        cell.selectionStyle = .none
        cell.factDetailsDict = viewModelFacts.factsDataList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


