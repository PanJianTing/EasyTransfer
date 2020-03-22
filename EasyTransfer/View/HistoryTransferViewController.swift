//
//  HistoryTransferViewController.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class HistoryTransferViewController: UIViewController {

    var historyTransferTableView:UITableView!
    
    var fullScreenSize : CGSize! {
        return ViewUtil.getFullScreenSize(vc: self);
        
    }
    var navigationBarHeight : CGFloat! {
        return ViewUtil.getNavigationHeight(navigationViewController: self.navigationController);
    }
    
    var transferViewModels:[TransferViewModel]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "歷史轉帳";
        self.setTableView();
        self.transferViewModels = (UIApplication.shared.delegate as! AppDelegate).coreData.getTransfers(queryStr: nil);
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.historyTransferTableView.reloadData();
    }
    
    

    private func setTableView(){
        self.historyTransferTableView = UITableView(frame: CGRect(x: 0, y: self.navigationBarHeight, width: self.fullScreenSize.width, height: self.fullScreenSize.height));
        
        self.historyTransferTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell");
        self.historyTransferTableView.delegate = self;
        self.historyTransferTableView.dataSource = self;
        
        
        self.historyTransferTableView.allowsSelection = true;
        self.historyTransferTableView.allowsMultipleSelection = false;
        
        self.view.addSubview(self.historyTransferTableView);
    }

}
