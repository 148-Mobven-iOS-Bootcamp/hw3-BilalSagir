import Foundation

let sampleDate: Date = Date(timeIntervalSinceReferenceDate: -12345678.0)

extension Date
{
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    
    var dateAsPrettyString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd<>MM<>yyyy"
        return formatter.string(from: self)
    }
}


print(sampleDate)   //2000-08-11 02:38:42 +0000
print(sampleDate.day)   //11
print(sampleDate.month) //08
print(sampleDate.year)  //2000
print(sampleDate.dateAsPrettyString)    //11<>08<>2000
