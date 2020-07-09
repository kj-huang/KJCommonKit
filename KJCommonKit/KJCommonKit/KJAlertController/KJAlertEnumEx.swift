
//
//  KJAlertEnumEx.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation


extension KJAlertController {
    
    @objc(KJAlertControllerStyle)
    public enum Style: Int {
        
        case sheet = 0
        
        case alert = 1
        
    }
}

extension KJAlertAction {
    
    @objc(KJAlertActionStyle)
    public enum Style: Int {
        
        case `default` = 0
        
        case cancel = 1
        
        case destructive = 2
        
    }
}
