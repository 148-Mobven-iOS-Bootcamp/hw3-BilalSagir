import Foundation

class CalculatorBrain{
    
    func setOperand(operand: Double) {
        accumlator = operand
    }
    
    var accumlator = 0.0
    var historyLabel = ""
    
    enum OperationType{
        case Cons(Double)
        case SingleInput((Double) -> Double)
        case DualInput((Double, Double) -> Double)
        case Equal
        case ClearAll
    }
    
    var operations: Dictionary<String,OperationType> = [
        "CE" : OperationType.Cons(0),
        
        "C": OperationType.ClearAll,
        
        "√" : OperationType.SingleInput(sqrt),
        "+" : OperationType.DualInput({$0 + $1}),
        "-" : OperationType.DualInput({$0 - $1}),
        "÷" : OperationType.DualInput({$0 / $1}),
        "x" : OperationType.DualInput({$0 * $1}),
        
        "=" : OperationType.Equal
    ]
    
    func perfomOperations(symbol: String) {
        if let operation = operations[symbol] {
            switch operation{
            case .Cons(let value):
                accumlator = value
                
            case .SingleInput(let foo):
                historyLabel = symbol + " " + accumlator.clean
                
                accumlator = foo(accumlator)
            
            case .DualInput(let foo):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: accumlator, operationB: symbol)
                
            case .Equal:
                executePendingBinaryOperation()
            
            case .ClearAll:
                pending = nil
                pending?.firstOperand = 0.0
                accumlator = 0.0
                historyLabel = "ALL CLEAR"
                
            }
        }
    }
    
    func executePendingBinaryOperation(){
        if pending != nil{
            
            historyLabel = pending!.firstOperand.clean + " " + pending!.operationB + " " + accumlator.clean
  
            accumlator = pending!.binaryFunction(pending!.firstOperand, accumlator)
            pending = nil
        }
    }
    
    var pending: PendingBinaryOperationInfo?
    struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: (Double)
        var operationB: (String)
    }
    
    
    
    var result: Double{
        get{
            return accumlator
        }
    }
    
}


extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
