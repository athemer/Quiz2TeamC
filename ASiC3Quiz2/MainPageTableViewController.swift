//
//  MainPageTableViewController.swift
//  ASiC3Quiz2
//
//  Created by 陳冠華 on 2017/4/7.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit

class MainPageTableViewController: UITableViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpTitle()
        registerCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPageTableViewCell") as! MainPageTableViewCell
        // swiftlint:disable:previous force_cast
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 212
//    }

    func registerCell() {
        let articleNib = UINib(nibName: "MainPageTableViewCell", bundle: nil)
        self.tableView.register(articleNib, forCellReuseIdentifier: "MainPageTableViewCell")
    }
    
    func setUpTitle() {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "    My Journals"
        longTitleLabel.font.withSize(40)
        longTitleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
}
