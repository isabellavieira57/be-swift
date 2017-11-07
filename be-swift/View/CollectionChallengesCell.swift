//
//  CollectionChallengesCell.swift
//  be-swift
//
//  Created by Ana Müller on 10/28/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import Foundation
import UIKit

class CollectionChallengesCell: UICollectionViewCell
{
    
    var challengeIcon: UIImageView!
    var starsIcon: UIImageView!
    
    var starsImageName = ""
    var challengeImageName = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    func configureCell(numberOfStars: Int, isLocked: Bool, iconNumber: Int)
    {
        
        var cellWidth = self.bounds.width
        var cellHeight = self.bounds.height
        
        var challengeIcon = UIImageView(frame: CGRect(x: cellWidth/2 - 24, y: cellHeight/5, width: 48, height: 47))
        var starsIconY = challengeIcon.frame.origin.y + challengeIcon.frame.height + 5
        var starsIcon = UIImageView(frame: CGRect(x: cellWidth/2 - 28, y: starsIconY, width: 56, height: 17))
        
        switch numberOfStars
        {
        case 0:
            starsImageName = "noStars"
        case 1:
            starsImageName = "oneStar"
        case 2:
            starsImageName = "twoStars"
        case 3:
            starsImageName = "threeStars"
        default:
            starsImageName = ""
        }
        
        starsIcon.image = UIImage(named: starsImageName)
        
        if isLocked == true
        {
            challengeImageName = "challengeLocked"
        } else
        {
            challengeImageName = "challengeIcon"
        }
        
        challengeIcon.image = UIImage(named: challengeImageName)
        
        var challengeNumber = UILabel(frame: challengeIcon.frame)
        challengeNumber.text = String(iconNumber)
        challengeNumber.textAlignment = .center
        challengeNumber.textColor = UIColor.white
        
        self.addSubview(challengeIcon)
        self.addSubview(starsIcon)
        self.addSubview(challengeNumber)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

