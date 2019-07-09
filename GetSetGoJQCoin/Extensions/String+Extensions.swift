import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start.hashValue ..< end.hashValue)])
    }
    
    var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        }
    }
}

// MARK: - NSAttributedString extensions
public extension String {
    
    //converDate
    func convertDate(withFormat format: String = "yyyy/MM/dd")-> String?{
        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.timeZone = TimeZone.init(secondsFromGMT: 0)
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        if let date = dateFormatterGet.date(from: self) {
            let convertatedDate = dateFormatterPrint.string(from: date)
            return convertatedDate
        } else {
            print("There was an error decoding the string")
        }
        
        return ""
        
    }
    
    
    
    
    /// generate Qr code
        var qrCode: UIImage? {
            guard
                let data = data(using: .isoLatin1),
                let filter = CIFilter(name: "CIQRCodeGenerator")
                else { return nil }
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("M", forKey: "inputCorrectionLevel")
            guard let image = filter.outputImage
                else { return nil }
            let size = image.extent.integral
            let output = CGSize(width: 250, height: 250)
            let matrix = CGAffineTransform(scaleX: output.width / size.width, y: output.height / size.height)
            UIGraphicsBeginImageContextWithOptions(output, false, 0)
            defer { UIGraphicsEndImageContext() }
            UIImage(ciImage: image.transformed(by: matrix))
                .draw(in: CGRect(origin: .zero, size: output))
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    
    /// Regular string.
    public var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
    public var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Underlined string
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// Italic string.
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
}

extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

