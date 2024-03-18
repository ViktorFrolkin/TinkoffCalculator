//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by macOS on 27.02.2024.
//

import UIKit

enum CalculationError:  Error {
    case divideByZero
    
}

enum Operation: String {
    
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case divide = "/"
    
    func calculate(_ number1: Double, number2: Double) throws -> Double {
        switch self {
        case .add:
            return number1 + number2
            
        case .substract:
            return number1 - number2
            
        case .multiply:
            return number1 * number2
            
        case .divide:
            if number2 == 0 {
                throw CalculationError.divideByZero
            }
            return number1 / number2
        }
    }
    
}
enum CalculationHistoryItem {
    
    case number (Double)
    case operation (Operation)
}

class ViewController: UIViewController {
    var calculationHistory: [CalculationHistoryItem] = []
    var calculations: [Calculation] = []
    
   let calculationHistoryStorage = CalculationHistoryStorage()
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    
    guard let buttonText = sender.currentTitle else { return
            }
        if label.text == "0" && buttonText == "," || label.text == "Ошибка" && buttonText == "," {
            label.text = "0,"
        }
        if buttonText == "," && label.text?.contains(",") == true {
            return
        }
            
        if label.text == "0" || label.text == "Ошибка" {
            label.text = buttonText
        } else {
            label.text?.append(buttonText)
        }
        
        
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
    
    guard
        let buttonText = sender.currentTitle,
        let buttonOperation = Operation(rawValue: buttonText)
        else { return }
    guard
        let labelText = label.text,
        let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
        else { return }
      
        calculationHistory.append(.number(labelNumber))
        calculationHistory.append(.operation(buttonOperation))

        resetLabelText()
    }
    @IBAction func clearButtonPressed() {
        calculationHistory.removeAll()
        resetLabelText()
    }
    
    @IBAction func calculateButtonPressed() {
        guard
            
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
            else { return }
          
            calculationHistory.append(.number(labelNumber))
        do {
            let result = try calculate()
            label.text = numberFormatter.string(from:   NSNumber(value: result))
            
            let newCalculation = Calculation(expression: calculationHistory, result: result)
            calculations.append(newCalculation)
            calculationHistoryStorage.setHistory(calculation: calculations)
        } catch {
            label.text = "Ошибка"
        }
        calculationHistory.removeAll()
    }
   
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet var historyButton: UIButton!
    
  
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "ru-RU")
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resetLabelText()
        calculations = calculationHistoryStorage.loadHistory()
        historyButton.accessibilityIdentifier = "historyButton"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    @IBAction func showCalculationsList(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let calculationsListVC = sb.instantiateViewController(identifier: "CalculationsListViewController")
        if let vc = calculationsListVC as? CalculationsListViewController{
            vc.calculations = calculations
        }
        
        navigationController?.pushViewController(calculationsListVC, animated:  true)
    }
    
    func calculate ()  throws -> Double {
           guard case .number(let firstNumber) = calculationHistory[0] else { return 0}

           var currentResult = firstNumber
           
           for index in stride(from: 1, to: calculationHistory.count - 1, by:  2) {
               guard
                   case .operation(let operation) = calculationHistory[index],
                   case .number(let number) = calculationHistory[index + 1]
                   else { break }
               
               currentResult = try operation.calculate(currentResult, number2: number)
           }
           
           return currentResult

       }

    func resetLabelText() {
        label.text = "0"
    }

}

