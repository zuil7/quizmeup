//
//  DynmicHeightCollectionView.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import UIKit

class DynmicHeightCollectionView: UICollectionView {
  
  var isDynamicSizeRequired = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
      
      if self.intrinsicContentSize.height > frame.size.height {
        self.invalidateIntrinsicContentSize()
      }
      if isDynamicSizeRequired {
        self.invalidateIntrinsicContentSize()
      }
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
