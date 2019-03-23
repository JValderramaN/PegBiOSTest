//
//  UIViewController+PegBiOSTest.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(with error: Error) {
        let alertController = UIAlertController.alertFromError(error)
        self.present(alertController, animated: true, completion: nil)
    }

}
