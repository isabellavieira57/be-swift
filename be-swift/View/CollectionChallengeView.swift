//
//  CollectionChallengeView.swift
//  be-swift
//
//  Created by Isabella Vieira on 08/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//
import Foundation
import UIKit

class CollectionChallengeView: View {
    
    var collectionChallenges1: UICollectionView!
    var collectionChallenges2: UICollectionView!
    var starLabel: UILabel!
    var xpLabel: UILabel!
    
    let widhtiPhoneSE: CGFloat = 320
    let heightiPhoneSE: CGFloat = 568
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        
        setTopBarChallenges()
        setLevelLabel()
        setCollectionView()
        
    }
    
    func setTopBarChallenges()
    {
        let topBar = CAShapeLayer()
        topBar.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 321, height: 64))).cgPath
        topBar.fillColor = UIColor(red:0.40, green:0.43, blue:0.53, alpha:1.0).cgColor
        
        let starImage = UIImageView(frame: UIScreen.changeScale(vector: CGRect(x: 119, y: 28, width: 27, height: 26.03)))
        starImage.image = UIImage(named:"star")
        
        self.starLabel = UILabel(text: "006", font: "SanFranciscoText-Regular", fontSize: 19, aligment: .center, textColor: UIColor(red:2.55, green:2.34, blue:0.37, alpha:1.0), frame: CGRect(x: 153, y: 33, width: 37, height: 20))
        
        let xpImage = UIImageView(frame: UIScreen.changeScale(vector: CGRect(x: 230.29, y: 33, width: 27.62, height: 16)))
        xpImage.image = UIImage(named:"xp")
        
        self.xpLabel = UILabel(text: "4%", font: "SanFranciscoText-Regular", fontSize: 19, aligment: .center, textColor: UIColor(red:0.0, green:2.15, blue:2.23, alpha:1.0), frame: CGRect(x: 264, y: 33, width: 37, height: 20))
        
        self.layer.addSublayer(topBar)
        self.addSubview(starImage)
        self.addSubview(starLabel)
        //        self.addSubview(xpImage)
        //        self.addSubview(xpLabel)
    }
    
    func setCollectionView()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let layoutCollection: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutCollection.itemSize = CGSize(width: 94*xScale, height: 110*yScale)
        layoutCollection.minimumInteritemSpacing = 0
        layoutCollection.minimumLineSpacing = 0
        
        collectionChallenges1 = UICollectionView(frame: CGRect(x: 18*xScale, y: 131*yScale, width: 284*xScale, height: 475*yScale), collectionViewLayout: layoutCollection)
        collectionChallenges1.backgroundColor = UIColor.white
        collectionChallenges1.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionChallenges1)
    }
    
    func setLevelLabel()
    {
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE
        
        let levelLabel = UIImageView(frame: CGRect(x: 18*xScale, y: 93*yScale, width: 284*xScale, height: 38*yScale))
        levelLabel.image = UIImage(named: "Level1Label")
        
        self.addSubview(levelLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
