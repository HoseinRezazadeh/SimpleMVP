//
//  HomePresenter.swift
//  SimpleMVP
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 12/28/21.
//

import Foundation
import UIKit

protocol homePresenterDelegate : AnyObject {
    func presentResponseAPI(search : [DataListCellViewModel])
    func presentAlert(title : String , message : String)
}

typealias presenterDelegate = homePresenterDelegate & UIViewController

class HomePresenter {
    
    private var vms = [DataListCellViewModel]()
    private var datas: [Search] = [Search]()
    weak var delegate : presenterDelegate?
    
    public func setViewDelegate (delegate : presenterDelegate ) {
        self.delegate = delegate
    }
    
    
    public func fetchData(_ tieleSearch : String , PageNumber : Int) {
        RequestHelper.dataRequest(with: "http://www.omdbapi.com/?s=run&apikey=6ca8df0&page=\(PageNumber)", objectType: GeneralSearch.self) { [weak self] (result: Result) in
            switch result {
            case .success(let object):
                print(object)
                self?.createCell(datas: object.search)
            case .failure(let error):
                print(error)
                self?.delegate?.presentAlert(title: "ups!error", message: "somthings error : \(error)")
            }
        }
    }
    
    public func createCell(datas: [Search]){
         self.datas = datas
         for data in datas {
             vms.append(DataListCellViewModel(titleText: data.title!, typeText: data.type.rawValue,
                                              yearText: data.year!,
                                              imageURL: data.poster))
         }
        self.delegate?.presentResponseAPI(search: vms)
     }
   
}

