import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let feetToMeter = height * 0.304
        let bmiValue = weight / pow(feetToMeter, 2)
        
        switch bmiValue {
        case ..<18.5 :
            bmi = BMI(value: bmiValue, advice: "Eat more burgers", color: UIColor(red: 0.58, green: 0.80, blue: 0.97, alpha: 1.00))
        case 18.5...24.9 :
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor(red: 0.69, green: 0.79, blue: 0.49, alpha: 1.00))
        case 24.9... :
            bmi = BMI(value: bmiValue, advice: "Stop eating cakes", color: UIColor(red: 0.90, green: 0.54, blue: 0.53, alpha: 1.00))
        default:
            fatalError()
        }
        
    }
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? "0.0")
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
}

