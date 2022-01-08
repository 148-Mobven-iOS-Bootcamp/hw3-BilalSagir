import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var Screen: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet var functionButtons: [UIButton]!
    @IBOutlet var digitButtons: [UIButton]!
    
    
    func animationLOL(){
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.reveal
        animation.duration = 0.5
        Screen.layer.add(animation, forKey: CATransitionType.reveal.rawValue)
    }
    
    
    let brain = CalculatorBrain()
    
    var isScreenEmpty = false
    
    var displayResult: Double {
        get{
            return Double(Screen.text!)!
        }
        set{
            Screen.text = String(newValue)
        }
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton)
    {
        animationLOL()
        let digit = sender.currentTitle!
        if isScreenEmpty{
            Screen.text = Screen.text! + digit
        }
        else{
            Screen.text = digit
            isScreenEmpty.toggle()
        }
    }
    
    
    
    @IBAction func operationButtons(_ sender: UIButton)
    {
        animationLOL()
        calculationLabel.text = ""
        
        brain.setOperand(operand: displayResult)
        
        isScreenEmpty = false
        
        brain.perfomOperations(symbol: sender.currentTitle!)
        
        displayResult = brain.result
        
        calculationLabel.text = brain.historyLabel

    }
    
    
}


extension ViewController {
    override func viewDidLoad() {
        
        calculationLabel.text = ""
        
        for i in functionButtons{
            i.layer.cornerRadius = 40
        }
        
        for i in digitButtons{
            i.layer.cornerRadius = 40
        }
        
    }
}

