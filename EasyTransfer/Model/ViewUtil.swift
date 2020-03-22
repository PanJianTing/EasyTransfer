//
//  ViewUtil.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

class ViewUtil: NSObject {
    
    static func getFullScreenSize(vc:UIViewController) -> CGSize{
        let size = CGSize(width: vc.view.frame.size.width, height: vc.view.frame.size.height - (vc.tabBarController?.tabBar.frame.size.height ?? 0) )
        return size;
    }
    
    static func getNavigationHeight(navigationViewController:UINavigationController?) -> CGFloat{
        return UIApplication.shared.statusBarFrame.height + (navigationViewController?.navigationBar.frame.size.height ?? 64);
    }
    
    static func setAlertViewController(title:String, message:String, confirmStr:String, cancelStr:String?, confirmHandler : (()->Void)? = nil) -> UIAlertController{
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert);
        let comfirmAction = UIAlertAction(title: confirmStr, style: .default) { (_) in
            
            if (confirmHandler != nil){
                confirmHandler!();
            }
            
        }
        alertController.addAction(comfirmAction)
        
        guard cancelStr != nil else {
            return alertController
        }
        
        let cancelAction = UIAlertAction(title: cancelStr, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        return alertController
    }

}