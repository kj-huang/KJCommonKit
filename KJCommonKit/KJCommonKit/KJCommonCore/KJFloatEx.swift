//
//  KJFloatEx.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    func kj_cgFloatValue() -> CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat {
    func kj_floatValue() -> Float {
        return Float(self)
    }
}
