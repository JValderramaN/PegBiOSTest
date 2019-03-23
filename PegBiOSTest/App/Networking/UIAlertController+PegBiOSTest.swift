//
//  UIAlertController+PegBiOSTest.swift
//  PegBiOSTest
//
//  Created by José Valderrama on 21/03/2019.
//  Copyright © 2019 José Valderrama. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func alertWithAcceptButton(title: String? = NSLocalizedString("Error", comment: ""),
                                    message: String? = NSLocalizedString("Ha ocurrido un error", comment: "")) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        return alert
    }
    
    class func alertFromError(_ error: Error) -> UIAlertController {
        return UIAlertController.alertWithAcceptButton(message: error.localizedDescription)
    }
    
}
