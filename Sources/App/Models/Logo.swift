import Vapor
import Foundation

struct Logo: Parameterizable, ResponseRepresentable, JSONRepresentable, Encodable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("thumbnailURL", thumbnailURL.absoluteString)
        try json.set("logoURL", logoURL?.absoluteString)
        try json.set("publishedAt", publishedAt)
        try json.set("id", id)
        return json
    }

    func makeResponse() throws -> Response {
        return try makeJSON().makeResponse()
    }

    static var uniqueSlug: String = "logo"

    static func make(for parameter: String) throws -> Logo {
        // TODO: Fill up logos
        guard parameter == "42" else {
            return Logo(thumbnailURL: URL(string: "http://example.com")!, logoURL: nil,  publishedAt: Date(), id: "")
        }
        return Logo(thumbnailURL: URL(string: "http://example.com")!, logoURL: URL(string: "http://example.com")!,  publishedAt: Date(), id: "")
    }

    var thumbnailURL: URL
    var logoURL: URL?
    var publishedAt: Date
    var id: String
}
