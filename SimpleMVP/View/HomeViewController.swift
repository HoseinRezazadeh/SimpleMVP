//
//  HomeViewController.swift
//  SimpleMVP
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 12/28/21.
//

import UIKit

class HomeViewController: UIViewController, homePresenterDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = HomePresenter()
    private var homeSearch = [DataListCellViewModel]()
    private var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presenter.setViewDelegate(delegate: self)
        presenter.fetchData("run" , PageNumber: pageNumber)
        }

    //MARK: - Presenter Delegate

    
    func presentResponseAPI(search: [DataListCellViewModel]) {
        self.homeSearch = search
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func presentAlert(title: String, message: String) {
        showAlert(message, title: title)
    }
    
    
}
//MARK: - UITableViewDataSource
extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeSearch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.configuration(titel: homeSearch[indexPath.row].titleText,
                           type: homeSearch[indexPath.row].typeText,
                           year: homeSearch[indexPath.row].yearText,
                           ImgaeURLString: homeSearch[indexPath.row].imageURL)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
   }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if indexPath.row == homeSearch.count - 1 {
           pageNumber += 1
           presenter.fetchData("run", PageNumber: pageNumber)
       }
    }
}
