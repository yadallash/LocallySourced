//
//  LaunchScreenView.swift
//  LocallySourced
//
//  Created by Clint Mejia on 3/4/18.
//  Copyright © 2018 TeamLocallySourced. All rights reserved.
//

import UIKit
import SnapKit

protocol LaunchViewDelegate {
    func animationEnded()
}

class LaunchScreenView: UIView, UICollisionBehaviorDelegate {
    
    var delegate: LaunchViewDelegate?
    
    //MARK: - Outlets
    lazy var imageViewOne: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "apple")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "artichoke")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewThree: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "asparagus")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFour: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "banana")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFive: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "broccoli")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewSix: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "carrot")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewSeven: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "celery")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewEight: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "eggplant")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewNine: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "grapes")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "lettuce")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewEleven: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "mushroom")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTwelve: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "peas")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewThirteen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "pineapple")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFourteen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "tomato")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFifteen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "watermelon")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Access Green"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Inititalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Functions
    private func commonInit() {
//        backgroundColor = UIColor(displayP3Red: 100/255, green: 180/255, blue: 130/255, alpha: 1)
        backgroundColor = UIColor.white
        addSubviews()
        setupViews()
        animateView()
    }
    
    private func addSubviews() {
        addSubview(imageViewOne)
        addSubview(imageViewTwo)
        addSubview(imageViewThree)
        addSubview(imageViewFour)
        addSubview(imageViewFive)
        addSubview(imageViewSix)
        addSubview(imageViewSeven)
//        addSubview(imageViewEight)
//        addSubview(imageViewNine)
//        addSubview(imageViewTen)
//        addSubview(imageViewEleven)
//        addSubview(imageViewTwelve)
//        addSubview(imageViewThirteen)
//        addSubview(imageViewFourteen)
//        addSubview(imageViewFifteen)
//        addSubview(nameLabel)
        addSubview(logoImageView)
    }
    
    private func setupViews() {
        setupImageViewOne()
        setupImageViewTWo()
        setupImageViewThree()
        setupImageViewFour()
        setupImageViewFive()
        setupImageViewSix()
        setupImageViewSeven()
//        setupNameLabel()
        setupLogoImageView()
    }
    
    func animateTranslation(with valueOne: CGFloat, with valueTwo: CGFloat, with valueThree: CGFloat, for image: UIImageView) {
        let toValue = CATransform3DMakeTranslation(valueOne, valueTwo, valueThree)
        let animation = CABasicAnimation(keyPath: "transform")
        animation.toValue = toValue
        animation.duration = 9
        let image = image
        image.layer.add(animation, forKey: nil)
    }
    
    private func animations() {
        animateTranslation(with: 200, with: 400, with: -100, for: self.imageViewOne)
        animateTranslation(with: -800, with: -100, with: -100, for: self.imageViewTwo)
        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewThree)
        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewFour)
        animateTranslation(with: -200, with: 400, with: 100, for: self.imageViewFive)
        animateTranslation(with: -200, with: 400, with: 100, for: self.imageViewSix)
        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewSeven)
    }
    
    private func fadeView() {
        self.imageViewOne.layer.opacity = 0
        self.imageViewTwo.layer.opacity = 0
        self.imageViewThree.layer.opacity = 0
        self.imageViewFour.layer.opacity = 0
        self.imageViewFive.layer.opacity = 0
        self.imageViewSix.layer.opacity = 0
        self.imageViewSeven.layer.opacity = 0
        self.nameLabel.layer.opacity = 0
    }
    
    private func animateView() {
        UIView.animate(withDuration: 4.0, animations: {
            self.animations()
        }) { (success:Bool) in
            if success {
                //Fade the entire view out
                UIView.animate(withDuration: 4.0, animations: {
                    self.fadeView()
                }) {(success) in
                    self.delegate?.animationEnded()
                }
            }
        }
    }

    // MARK: - SNP Constraints
    // apple image
    private func setupImageViewOne() {
        imageViewOne.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(snp.height).multipliedBy(0.08)
            make.width.equalTo(snp.height)
        }
    }
    
    // artichoke image
    private func setupImageViewTWo() {
        imageViewTwo.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-300)
            make.centerX.equalTo(snp.centerX).offset(200)
            make.height.equalTo(snp.height).multipliedBy(0.08)
            make.width.equalTo(snp.height)
        }
    }
    
    // asparagus image
    private func setupImageViewThree() {
        imageViewThree.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-100)
            make.centerX.equalTo(snp.centerX).offset(-175)
            make.height.equalTo(snp.height).multipliedBy(0.08)
            make.width.equalTo(snp.height)
        }
    }
    
    // banana image
    private func setupImageViewFour() {
        imageViewFour.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(300)
            make.centerX.equalTo(snp.centerX).offset(-200)
            make.height.equalTo(snp.height).multipliedBy(0.08)
            make.width.equalTo(snp.height)
        }
    }
    
    // broccoli image
    private func setupImageViewFive() {
        imageViewFive.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(89)
            make.centerX.equalTo(snp.centerX).offset(100)
            make.height.equalTo(snp.height).multipliedBy(0.04)
            make.width.equalTo(snp.height)
        }
    }
    
    // carrot image
    private func setupImageViewSix() {
        imageViewSix.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-24)
            make.centerX.equalTo(snp.centerX).offset(-70)
            make.height.equalTo(snp.height).multipliedBy(0.06)
            make.width.equalTo(snp.height)
        }
    }
    
    // celery image
    private func setupImageViewSeven() {
        imageViewSeven.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(80)
            make.centerX.equalTo(snp.centerX).offset(-100)
            make.height.equalTo(snp.height).multipliedBy(0.10)
            make.width.equalTo(snp.height)
        }
    }
    
    private func setupNameLabel() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY).offset(-150)
        }
    }
    
     private func setupLogoImageView() {
        logoImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.height).multipliedBy(0.25)
            make.height.equalTo(self).multipliedBy(0.25)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-150)
        }
    }
    
}
