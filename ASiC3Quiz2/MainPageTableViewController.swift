//
//  MainPageTableViewController.swift
//  ASiC3Quiz2
//
//  Created by 陳冠華 on 2017/4/7.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit
import CoreData

class MainPageTableViewController: UITableViewController {


    var dataArray: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.white

        fetchDataFromCoredata()
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


        let fetchedResult = dataArray[indexPath.row]

        if let photo = fetchedResult.value(forKey: "imageData") as? Data {
            cell.articleImage.image = UIImage(data: photo)
        }

        if let title = fetchedResult.value(forKey: "title") as? String {
            cell.articleTitle.text = title
        }


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let fetchedResult = dataArray[indexPath.row]

        let storyBoard = UIStoryboard(name: "EditPage", bundle: nil)
        guard let editPageViewController = storyBoard.instantiateViewController(withIdentifier: "EditPageViewController") as? EditPageViewController else { return }

        if let photo = fetchedResult.value(forKey: "imageData") as? UIImage {
            editPageViewController.imageView.image = photo
        }

        if let title = fetchedResult.value(forKey: "title") as? String {
            editPageViewController.titleTextField.text = title
        }

        if let content = fetchedResult.value(forKey: "content") as? String {
            editPageViewController.contentTextView.text = content
        }

        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(editPageViewController, animated: true)

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }

    func registerCell() {
        let articleNib = UINib(nibName: "MainPageTableViewCell", bundle: nil)
        self.tableView.register(articleNib, forCellReuseIdentifier: "MainPageTableViewCell")
    }

    func setUpTitle() {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "    My Journals"
        longTitleLabel.font = UIFont.systemFont(ofSize: 20)
        longTitleLabel.textColor = UIColor(red: 67/255, green: 87/255, blue: 97/255, alpha: 1)
        longTitleLabel.sizeToFit()

        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }

    func fetchDataFromCoredata () {

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Article")

        do {
            dataArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {

            print("Could not fetch.")
        }
        self.tableView.reloadData()
    }

    @IBAction func addTapped(_ sender: Any) {

        print ("cool")

        let storyBoard = UIStoryboard(name: "EditPage", bundle: nil)
        guard let editPageViewController = storyBoard.instantiateViewController(withIdentifier: "EditPageViewController") as? EditPageViewController else { return }

        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(editPageViewController, animated: true)

    }

}
