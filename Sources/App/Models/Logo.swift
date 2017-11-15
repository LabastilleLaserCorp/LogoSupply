import Vapor
import Foundation

struct Logo: Parameterizable, ResponseRepresentable, JSONRepresentable, Encodable {
    func makeJSON() throws -> JSON {
        let data = try JSONEncoder().encode(self)
        return try JSON(bytes: data)
    }

    func makeResponse() throws -> Response {
        return try makeJSON().makeResponse()
    }

    static var uniqueSlug: String = "logo"

    static func make(for parameter: String) throws -> Logo {
        // TODO: Fill up logos
        guard parameter == "42" else {
            return Logo(thumbnailURL: URL(string: "http://example.com")!, logoURL: nil,  publishedAt: Date(), id: UUID.init())
        }
        return Logo(thumbnailURL: URL(string: "http://example.com")!, logoURL: URL(string: "http://example.com")!,  publishedAt: Date(), id: UUID.init())
    }

    var thumbnailURL: URL
    var logoURL: URL?
    var publishedAt: Date
    var id: UUID
}
