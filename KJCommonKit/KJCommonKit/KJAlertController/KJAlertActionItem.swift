//
//  KJAlertActionItem.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import UIKit

class KJAlertActionItem: UICollectionViewCell {
    
    private lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0)
        backgroundColor = UIColor.white.withAlphaComponent(0)
        contentView.addSubview(lbTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var itemModel: KJAlertAction? {
        didSet {
            if let att = itemModel?.attTitle {
                lbTitle.attributedText = att
            } else {
                lbTitle.font = itemModel?.font
                lbTitle.textColor = itemModel?.titleColor
                lbTitle.text = itemModel?.title
            }
            if let layer = itemModel?.layer {
                contentView.layer.insertSublayer(layer, at: 0)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let layer = itemModel?.layer {
            layer.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        }
        lbTitle.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
    }
}
