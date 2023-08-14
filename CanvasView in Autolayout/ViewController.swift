//
//  ViewController.swift
//  CanvasView in Autolayout
//
//  Created by Tushar Khandaker on 15/8/23.
//

import UIKit

enum canvasRatio: String, CaseIterable {
    case oneOne = "1:1"
    case oneTwo = "1:2"
    case twoOne = "2:1"
    case nineSixteen = "9:16"
    case sixteenNine = "16:9"
    case fourThree = "4:3"
    
    var stringValue: String {
        return self.rawValue
    }
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageViewAspectRatio: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        canvasRatio.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCVCell", for: indexPath) as? CustomCVCell else {
            return UICollectionViewCell()
        }
        cell.ratioLabel.text = canvasRatio.allCases[indexPath.item].stringValue
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCanvas = canvasRatio.allCases[indexPath.item]
        changeCanvasSize(by: selectedCanvas)
        
    }
    
    func changeCanvasSize(by ratio: canvasRatio) {
        var currentRatio = 0.0
        switch ratio {
        case .oneOne:
            currentRatio = 1.0
        case .nineSixteen:
            currentRatio = 9/16
            
        case .sixteenNine:
            currentRatio = 16/9
            
        default:
            currentRatio = 5/4
            
        }
        UIView.animate(withDuration: 2.0) {
            self.imageViewAspectRatio.constant = currentRatio
            self.view.layoutIfNeeded()
        }
    }
}


class CustomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ratioLabel: UILabel!
}
