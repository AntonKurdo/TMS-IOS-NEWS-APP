import Foundation

class DateFormatter {
   static func dateISOToString(_ date: String) -> String {
        let newFormatter = ISO8601DateFormatter()
        
        let date = newFormatter.date(from: date)
        return date?.formatted(date: .complete, time: .shortened) ?? ""
    }
}
