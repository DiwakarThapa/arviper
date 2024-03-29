import Foundation

class ValidationError: Error {
    var message: String
    var type: String
    
    init(_ message: String, type: String) {
        self.message = message
        self.type = type
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
    case projectIdentifier
    case requiredField(field: String)
    case age
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .projectIdentifier: return ProjectIdentifierValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        }
    }
}

//"J3-123A" i.e
struct ProjectIdentifierValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project Identifier Format", type: "")
            }
        } catch {
            throw ValidationError("Invalid Project Identifier Format", type: "")
        }
        return value
    }
}


class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required", type: "age")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!", type: "age")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!", type: "age")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)", type: "age")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName, type: "required")
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters", type: "username" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters", type: "username" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters", type: "username")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters", type: "username")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(GlobalConstants.Localization.passwordEmptyAlert, type: "password")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters", type: "password") }
        //^(?=.\\d)(?=.[a-z])(?=.[A-Z])[0-9a-zA-Z!@#$%^&()\-_=+{}|?>.<,:;~`’]{8,}$
        //^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$
//        do {
//            if try NSRegularExpression(pattern: "^(?=.\\d)(?=.[a-z])(?=.[A-Z])[0-9a-zA-Z!@#$%^&()\\-_=+{}|?>.<,:;~`’]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
//            }
//        } catch {
//            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
//        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(GlobalConstants.Localization.userAndEmailEmptyAlert, type: "email")}
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("invalid login credentials", type: "email")
            }
        } catch {
            throw ValidationError("invalid login credentials", type: "email")
        }
        return value
    }
}
