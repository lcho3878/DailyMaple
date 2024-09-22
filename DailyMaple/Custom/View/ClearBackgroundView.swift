//
//  ClearBackgroundView.swift
//  DailyMaple
//
//  Created by 이찬호 on 9/22/24.
//

import UIKit

class ClearBackgroundView: UIView {
    open override func layoutSubviews() {
        guard let parentView = superview?.superview else {
            return
        }
        parentView.backgroundColor = .clear
    }
}
