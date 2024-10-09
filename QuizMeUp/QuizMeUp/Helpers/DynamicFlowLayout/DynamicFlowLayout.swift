//
//  DynamicFlowLayout.swift
//  QuizMeUp
//
//  Created by Louise on 10/8/24.
//  Copyright © 2024 Louise Nicolas Namoc. All rights reserved.
//

import UIKit

class DynamicFlowLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
    var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()

    var leftMargin: CGFloat = sectionInset.left

    for attributes in attributesForElementsInRect! {
      if attributes.frame.origin.x == sectionInset.left {
        leftMargin = sectionInset.left
      } else {
        var newLeftAlignedFrame = attributes.frame

        if leftMargin + attributes.frame.width < collectionViewContentSize.width {
          newLeftAlignedFrame.origin.x = leftMargin
        } else {
          newLeftAlignedFrame.origin.x = sectionInset.left
        }

        attributes.frame = newLeftAlignedFrame
      }
      leftMargin += attributes.frame.size.width + 8
      newAttributesForElementsInRect.append(attributes)
    }

    return newAttributesForElementsInRect
  }
}
