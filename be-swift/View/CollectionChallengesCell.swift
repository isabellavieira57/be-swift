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
    
    //    var challengeIcon: UIImageView!
    //    var starsIcon: UIImageView!
    
    var starsImageName = ""
    var challengeImageName = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    func configureCell(numberOfStars: Int, isLocked: Bool, iconNumber: Int)
    {
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let cellWidth = self.bounds.width
        let cellHeight = self.bounds.height
        
        let challengeIcon = UIImageView(frame: CGRect(x: cellWidth/2 - 24*xScale, y: cellHeight/5, width: 48*xScale, height: 47*yScale))
        let starsIconY = challengeIcon.frame.origin.y + challengeIcon.frame.height + 5*yScale
        let starsIcon = UIImageView(frame: CGRect(x: cellWidth/2 - 28*xScale, y: starsIconY, width: 56*xScale, height: 17*yScale))
        
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
        
        let challengeNumber = UILabel(frame: challengeIcon.frame)
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
