//
//  AccountDetailViewController.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class AccountDetailViewController: UIViewController {
    
    var accountViewModel : AccountViewModel!;
    
    var nameLabel:UILabel!
    var accountLable:UILabel!
    var balanceLebel:UILabel!
    var transferButton:UIButton!
    
    var fullScreenSize : CGSize! {
        return ViewUtil.getFullScreenSize(vc: self)
        
    }
    var navigationBarHeight : CGFloat! {
        return ViewUtil.getNavigationHeight(navigationViewController: self.navigationController);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "帳戶明細";
        self.view.backgroundColor = UIColor.white;
        setTransferButton();
        setNameLabel();
        setAccountLabel();
        setBalanceLabel();
        
        let queryStr = "bankCode !=\(accountViewModel.getAccount().bankCode!) && accountNumber!=\(String(describing: accountViewModel.getAccount().accountNumber!))"
        canTransferAccountModels = (UIApplication.shared.delegate as! AppDelegate).coreData.getAccounts(queryStr: queryStr);

        // Do any additional setup after loading the view.
    }
    
    // MARK:Setting View Component
    private func setTransferButton(){
        self.transferButton =  UIButton(frame: CGRect(x: 20, y: fullScreenSize.height-70, width: fullScreenSize.width-40, height: 40));
        self.transferButton.setTitle("轉帳", for: .normal)
        self.transferButton.setTitleColor(UIColor.white, for: .normal);
        self.transferButton.backgroundColor = UIColor.blue;
        self.transferButton.addTarget( self, action: #selector(clickTransferButton), for:.touchUpInside)
        self.view.addSubview(self.transferButton);
    }
    
    private func setNameLabel(){
        self.nameLabel = UILabel(frame: CGRect(x: 20, y:self.navigationBarHeight+10, width: self.fullScreenSize.width, height: 40))
        self.nameLabel.text = "戶名：\(self.accountViewModel.showName)";
        self.nameLabel.textColor = UIColor.black;
        self.nameLabel.sizeToFit()
        self.view.addSubview(self.nameLabel);
    }
    
    private func setAccountLabel(){
        self.accountLable = UILabel(frame: CGRect(x: 20, y:self.navigationBarHeight+60, width: self.fullScreenSize.width, height: 40))
        self.accountLable.text = "帳戶：\(self.accountViewModel.showAccountStr)";
        self.accountLable.textColor = UIColor.black;
        self.accountLable.sizeToFit()
        
        self.view.addSubview(self.accountLable);
    }
    
    private func setBalanceLabel(){
        self.balanceLebel = UILabel(frame: CGRect(x: 20, y:self.navigationBarHeight+120, width: self.fullScreenSize.width, height: 40))
        self.balanceLebel.text = "餘額：\(self.accountViewModel.showBalance)";
        self.balanceLebel.textColor = UIColor.black;
        self.balanceLebel.sizeToFit()
        
        self.view.addSubview(self.balanceLebel);
    }
    
    @objc func clickTransferButton(){
        
        let nextViewController = ViewController()
        let transferViewModel = TransferViewModel();
        nextViewController.isTransferMode = true
        transferViewModel.fromAccount = self.accountViewModel;
        nextViewController.transferViewModel = transferViewModel;
        self.navigationController?.pushViewController(nextViewController, animated: true);
        
    }
}

