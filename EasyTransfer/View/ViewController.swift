//
//  ViewController.swift
//  EasyTransfer
//
//  Created by PanJianTing on 2020/3/21.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var accountTableView:UITableView!
    
    var fullScreenSize : CGSize! {
        return ViewUtil.getFullScreenSize(vc: self);
        
    }
    var navigationBarHeight : CGFloat! {
        return ViewUtil.getNavigationHeight(navigationViewController: self.navigationController);
    }
    
    var isTransferMode = false;
    var transferViewModel:TransferViewModel?
    var accountViewModels:[AccountViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "我的帳戶";
        self.setTableView();
        self.accountViewModels = (UIApplication.shared.delegate as! AppDelegate).coreData.getAccounts(queryStr: nil);
         
        print("Transfer Mode : \(isTransferMode)");
        
        // Do any additional setup after loading the view.ㄑ
    }
    
    // MARK:Set View Component
    private func setTableView(){
        self.accountTableView = UITableView(frame: CGRect(x: 0, y: self.navigationBarHeight, width: self.fullScreenSize.width, height: self.fullScreenSize.height));
        
        self.accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell");
        self.accountTableView.delegate = self;
        self.accountTableView.dataSource = self;
        
        
        self.accountTableView.allowsSelection = true;
        self.accountTableView.allowsMultipleSelection = false;
        
        self.view.addSubview(self.accountTableView);
    }


}

