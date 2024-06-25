import Foundation

class DateFormatUtil {
    static func dateISOToString(_ date: String, format: String? = "dd MMM YYYY") -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertedDate = dateFormatter.date(from: date)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = format
        
        if let d = convertedDate {
            return formatter2.string(from: d)
        }
        
        return ""
    }
}
