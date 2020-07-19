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
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addRefreshControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpValues()
    }

    //MARK:- ADD REFRESH CONTROLLER
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
//        let title = NSLocalizedString("Loading", comment: "Pull to refresh")
//        refreshControl!.attributedTitle = NSAttributedString(string: title)
        refreshControl?.tintColor = UIColor.lightGray
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tblView.addSubview(refreshControl!)
    }
    
    //MARK:- REFRESH CONTROLLER ACTION METHOD
    @objc func refreshList() {
        refreshControl?.endRefreshing()
        setUpValues()
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
        tblView.tableFooterView = UIView.init(frame: .zero)
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
    
    //MARK:- CALLING SERIVE
    func setUpValues(){
        self.showSpinner(onView: self.view)
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            self.viewModelFacts.fetchData(vc: self) { (isSuccess) in
               if isSuccess{
                   DispatchQueue.main.async { // Using GCD to run UI thread concurrantly
                    print("This is run on the main queue, after the previous code in outer block")

                       self.title = self.viewModelFacts.title
                       self.tblView.reloadData()
                   }
               }
           }
            
        }
    }
}

// MARK: UITableViewDelegate && UITableViewDataSource METHODS
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

