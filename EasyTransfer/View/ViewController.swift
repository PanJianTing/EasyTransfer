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
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "我的帳戶";
        self.setTableView();
        
        guard self.accountViewModels != nil else {
            self.accountViewModels = (UIApplication.shared.delegate as! AppDelegate).coreData.getAccounts(queryStr: nil);
            return;
        }
        
        print("Transfer Mode : \(isTransferMode)");
        
        
        // Do any additional setup after loading the view.ㄑ
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isTransferMode {
            self.title = "轉給"
            return;
        }
        self.tabBarController?.tabBar.isHidden = false;
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
    
    // MARK:Customization Func
    
    func handleCanTransferAccounts(removeAccount:AccountViewModel) -> [AccountViewModel]?{
        var canTransferAccounts:[AccountViewModel]? = [];
        
        guard (self.accountViewModels?.count ?? 0) > 0 else {
            return nil
        }
        for accountViewModel in self.accountViewModels! {
            if accountViewModel != removeAccount {
                canTransferAccounts?.append(accountViewModel);
            }
        }
        return canTransferAccounts
    }


}

