//
//  ViewUtil.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit

public let ButtonColor = UIColor.init(red: 0.0/255, green: 114.0/255, blue: 153.0/255, alpha: 1);

class ViewUtil: NSObject {
    
    static func getFullScreenSize(vc:UIViewController) -> CGSize{
        
        var tabberHeight = vc.tabBarController?.tabBar.frame.size.height
        
        if (vc.tabBarController?.tabBar.isHidden)!{
            tabberHeight = 0;
        }
        
        let size = CGSize(width: vc.view.frame.size.width, height: vc.view.frame.size.height - (tabberHeight ?? 0) )
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
