//
//  TransferResultViewController.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class TransferResultViewController: UIViewController {

    var transferViewModel:TransferViewModel!;
    
    var fullScreenSize : CGSize! {
        return ViewUtil.getFullScreenSize(vc: self)
        
    }
    var navigationBarHeight : CGFloat! {
        return ViewUtil.getNavigationHeight(navigationViewController: self.navigationController);
    }
    
    var priceLabel:UILabel!
    var detailLabel:UILabel!
    var priceTextField:UITextField!
    var detailTextField:UITextField!
    var confirmButton:UIButton!
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.transferViewModel.showToAccountStr();
        self.view.backgroundColor = UIColor.white;
        self.setConfirmButton();
        self.setPriceLabel();
        self.setDetailLabel();
        self.setPriceTextField();
        self.setPriceTextFieldToolBar()
        self.setDetailTextField();
        self.setViewTouch();

        // Do any additional setup after loading the view.
    }

    
    // MARK: View Component
    private func setConfirmButton(){
        self.confirmButton =  UIButton(frame: CGRect(x: 20, y: fullScreenSize.height-70, width: fullScreenSize.width-40, height: 40));
        self.confirmButton.setTitle("確定", for: .normal)
        self.confirmButton.setTitleColor(UIColor.white, for: .normal);
        self.confirmButton.backgroundColor = ButtonColor;
        self.confirmButton.layer.cornerRadius = 20;
        self.confirmButton.addTarget( self, action: #selector(clickConfirmButton), for:.touchUpInside)
        self.view.addSubview(self.confirmButton);
    }
    
    private func setPriceLabel(){
        self.priceLabel = UILabel(frame: CGRect(x: 20, y:self.navigationBarHeight+10, width: self.fullScreenSize.width, height: 40))
        self.priceLabel.text = "金額：";
        self.priceLabel.textColor = UIColor.black;
        self.priceLabel.sizeToFit()
        self.view.addSubview(self.priceLabel);
    }
    
    private func setDetailLabel(){
        self.detailLabel = UILabel(frame: CGRect(x: 20, y:self.navigationBarHeight+60, width: self.fullScreenSize.width, height: 40))
        self.detailLabel.text = "明細：";
        self.detailLabel.textColor = UIColor.black;
        self.detailLabel.sizeToFit()
        
        self.view.addSubview(self.detailLabel);
    }
    
    private func setPriceTextField(){
        self.priceTextField = UITextField(frame: CGRect(x: self.priceLabel.frame.width+20,
                                                        y:self.navigationBarHeight+10,
                                                        width: self.fullScreenSize.width-self.priceLabel.frame.width-40,
                                                        height: self.priceLabel.frame.height))
        self.priceTextField.attributedPlaceholder = NSAttributedString(string: "請輸入金額", attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        self.priceTextField.textColor = UIColor.black;
        
        self.priceTextField.keyboardType = .numberPad;
        self.priceTextField.returnKeyType = .done;
        
        self.priceTextField.delegate = self;
        
        self.view.addSubview(self.priceTextField);
    }
    
    private func setDetailTextField(){
        self.detailTextField = UITextField(frame: CGRect(x: self.detailLabel.frame.width+20,
                                                         y:self.navigationBarHeight+60,
                                                         width: self.fullScreenSize.width-self.detailLabel.frame.width-40,
                                                         height: self.detailLabel.frame.height))
        self.detailTextField.attributedPlaceholder = NSAttributedString(string:"請輸入明細", attributes:[NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        self.detailTextField.textColor = UIColor.black;
        
        self.detailTextField.keyboardType = .emailAddress;
        self.detailTextField.returnKeyType = .done;
        
        self.detailTextField.delegate = self;
        
        self.view.addSubview(self.detailTextField);
    }
    
    private func setPriceTextFieldToolBar(){
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.fullScreenSize.width, height: 30));
        
        let flexSpace = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hiddenKeyBoard))
        
        toolBar.setItems([flexSpace, doneButton], animated: false);
        toolBar.sizeToFit();
        
        self.priceTextField.inputAccessoryView = toolBar;
    }
    
    private func setViewTouch(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyBoard));
        tap.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tap);
    }
    
    @objc func clickConfirmButton(){
        guard self.priceTextField.text != "" else {
            let alertView = ViewUtil.setAlertViewController(title: "注意", message: "請輸入金額！", confirmStr: "確定", cancelStr: nil, confirmHandler: nil)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        let price:Int = Int(self.priceTextField.text!)!;
        let detailStr = self.detailTextField.text;
        
        let confirmTransferAlertView = ViewUtil.setAlertViewController(title: "注意", message: "確認要轉帳嗎？", confirmStr: "確認", cancelStr: "取消") {
            
            self.transferViewModel?.price = price;
            self.transferViewModel?.detailStr = detailStr ?? "";
            
            let result = self.transferViewModel.handleTransfer();
            if (result == ""){
                let successAlertView = ViewUtil.setAlertViewController(title: "成功", message: "轉帳成功", confirmStr: "確認", cancelStr: nil){
                    DispatchQueue.main.async{
                        self.navigationController?.popToRootViewController(animated: true);
                    }
                }
                self.present(successAlertView, animated: true, completion: nil)
                
            }else{
                let failAlertView = ViewUtil.setAlertViewController(title: "失敗", message: result, confirmStr: "確認", cancelStr: nil)
                self.present(failAlertView, animated: true, completion: nil);
            }
        }
        
        self.present(confirmTransferAlertView, animated: true, completion: nil)
        
    }
    
    @objc func hiddenKeyBoard(){
        self.view.endEditing(true);
    }

}
