//
//  homepageVC.swift
//  BlindfoldChessPuzzles
//
//  Created by Marty McCluskey on 12/9/19.
//  Copyright © 2019 Marty McCluskey. All rights reserved.
//

import UIKit

class homepageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pInfo = puzzleInfo()
    }
    
    var pInfo: puzzleInfo?
    
    @IBOutlet weak var numTurnsField: UITextField!
    @IBOutlet weak var genPuzzButton: UIButton!
    
    // get value for playerMove
    func getPlayerMove() -> String {
        if let pDir = self.pInfo!.folderPath {
            if let filepath = Bundle.main.path(forResource: "playerMove", ofType: ".txt", inDirectory: pDir) {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    return contents
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
        }
        return "test"
    }
    
    func setPFilePath () {
        let fM = FileManager.default
        if let numTurns = numTurnsField.text {
            if let pAudioPath = Bundle.main.path(forResource:"PuzzleAudio/\(numTurns)", ofType: nil)  {
                do{
                    let files = try fM.contentsOfDirectory(atPath: pAudioPath)  as [String]
                    if let pFolder = files.randomElement() {
                         self.pInfo?.folderPath = "PuzzleAudio/\(numTurns)/\(pFolder)"
                    }
                } catch {
                    print("error occured creating PuzzleAudio path")
                }
            }
            
        }
        
    }
    
    //make the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.setPFilePath()
        
        if let folderPath = self.pInfo!.folderPath {
            print(folderPath)
        }
        
        self.pInfo?.numTurns = numTurnsField.text
        self.pInfo?.playerMove = self.getPlayerMove()
        
        let pVC = segue.destination as! puzzleVC
        pVC.pInfo = self.pInfo
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if  let numTurns = numTurnsField.text, numTurns.count >= 1 {
            return true
        }
        let alertController = UIAlertController(title: "Error", message: "Please enter puzzle length", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        return false 
    }
   

}
