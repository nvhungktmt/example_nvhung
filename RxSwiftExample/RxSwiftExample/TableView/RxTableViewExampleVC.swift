//
//  RxTableViewExampleVC.swift
//  RxSwiftExample
//
//  Created by Hung NV on 1/21/22.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class RxTableViewExampleVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var itemNames = ["UITableView","UICollectionView"].map({RxTableViewExampleItem($0)})
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.of(itemNames)
        tableView.register(UINib(nibName: "RxTableViewExampleCell", bundle: nil), forCellReuseIdentifier: "RxTableViewExampleCell")
        items.bind(to: tableView.rx.items){ (tableView: UITableView, index: Int, element: RxTableViewExampleItem) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RxTableViewExampleCell", for: IndexPath(row: index, section: 0)) as! RxTableViewExampleCell
            cell.lblName.text = element.title
            return cell

        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(RxTableViewExampleItem.self).subscribe { model in
            print(model.title)
        } onError: { error in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }

        
        // Do any additional setup after loading the view.
    }
    
    
    
}

class RxTableViewExampleItem{
    var title: String?
    init(_ title: String?) {
    self.title = title
    }
}
