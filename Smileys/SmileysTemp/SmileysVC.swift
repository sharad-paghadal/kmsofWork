//
//  SmileysVC.swift
//  SmileysTemp
//
//  Created by Sharad Paghadal on 02/12/16.
//  Copyright © 2016 temp. All rights reserved.
//

import UIKit

class SmileysVC: UIViewController, UIGestureRecognizerDelegate {
    
    var minScale : CGFloat = 0
    var currentScale : CGFloat = 0
    var maxScale : CGFloat = 0

    @IBOutlet var mySmileyFace: Smileys!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchFn))
        mySmileyFace.addGestureRecognizer(pinchGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftFn))
        swipeLeft.direction = .left
        mySmileyFace.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightFn))
        swipeRight.direction = .right
        mySmileyFace.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpFn))
        swipeUp.direction = .up
        mySmileyFace.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownFn))
        swipeDown.direction = .down
        mySmileyFace.addGestureRecognizer(swipeDown)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateFn))
        mySmileyFace.addGestureRecognizer(rotate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pinchFn(_ Gesture: UIPinchGestureRecognizer){
        mySmileyFace.pinch(Gesture)
    }
    
    func swipeLeftFn(_ Gestureleft: UISwipeGestureRecognizer){
        mySmileyFace.left(Gestureleft)
    }
    
    func swipeRightFn(_ Gestureright: UISwipeGestureRecognizer){
        mySmileyFace.right(Gestureright)
    }
    
    func swipeUpFn(_ Gestureup: UISwipeGestureRecognizer){
        mySmileyFace.up(Gestureup)
    }
    
    func swipeDownFn(_ Gesturedown: UISwipeGestureRecognizer){
        mySmileyFace.down(Gesturedown)
    }
    
    func rotateFn(_ Gesturerotate: UIRotationGestureRecognizer){
        mySmileyFace.rotate(Gesturerotate)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
