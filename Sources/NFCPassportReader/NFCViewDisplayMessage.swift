//
//  NFCViewDisplayMessage.swift
//  NFCPassportReader
//
//  Created by Andy Qua on 09/02/2021.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
public enum NFCViewDisplayMessage {
    case requestPresentPassport
    case authenticatingWithPassport(Int)
    case readingDataGroupProgress(DataGroupId, Int)
    case error(NFCPassportReaderError)
    case activeAuthentication
    case successfulRead
}

@available(iOS 13, macOS 10.15, *)
extension NFCViewDisplayMessage {
    public var description: String {
        switch self {
        case .requestPresentPassport:
            return "Kimliği telefonun arkasına yaklaştırın."

        case .authenticatingWithPassport(let progress):
            let percent = max(0, min(100, progress))
            return "%\(percent)"

        case .readingDataGroupProgress(_, let progress):
            let percent = max(0, min(100, progress))
            return "%\(percent)"

        case .error(let tagError):
            switch tagError {
            case NFCPassportReaderError.TagNotValid:
                return "Kimlik etiketi geçerli değil."

            case NFCPassportReaderError.MoreThanOneTagFound:
                return "Birden fazla kimlik algılandı. Lütfen yalnızca bir kimlik gösterin."

            case NFCPassportReaderError.ConnectionError:
                return "Bağlantı hatası. Lütfen tekrar deneyin."

            case NFCPassportReaderError.InvalidMRZKey:
                return "Bu kimlik için güvelik anahtarı geçerli değil."

            case NFCPassportReaderError.ResponseError(let description, let sw1, let sw2):
                return "Kimlik okunurken bir sorun oluştu. Lütfen tekrar deneyin."

            default:
                return "Kimlik okunurken bir hata oluştu. Lütfen tekrar deneyin."
            }

        case .activeAuthentication:
            return "Doğrulama yapılıyor..."

        case .successfulRead:
            return "Kimlik başarıyla okundu."
        }
    }
    
    func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress/20)
        let full = String(repeating: "🟢 ", count: p)
        let empty = String(repeating: "⚪️ ", count: 5-p)
        return "\(full)\(empty)"
    }
}

