//
//  CustomFlowLayout.swift
//  Muslink
//
//  Created by Аброрбек on 10.08.2023.
//

import UIKit

final class CustomViewFlowLayout : UICollectionViewFlowLayout {

    let cellSpacing:CGFloat = 12

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
        for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = CGRectGetMaxX(prevLayoutAttributes.frame)
            if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
}
