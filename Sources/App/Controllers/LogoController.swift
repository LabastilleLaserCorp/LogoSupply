//
//  LogoController.swift
//  LogoSupplyPackageDescription
//
//  Created by Seán Labastille on 15.11.17.
//

import Vapor
import Foundation
import HTTP

final class LogoController: ResourceRepresentable, EmptyInitializable {

    func index(_ req: Request) throws -> ResponseRepresentable {
        var logos = [JSON]()
        (1...6).map({logos.append(try! Logo(thumbnailURL: try! req.uri.appendingPathComponent("storage/icon_1024x1024-\($0).png").makeFoundationURL(), logoURL: try! req.uri.appendingPathComponent("storage/icon_120x120-\($0).png").makeFoundationURL(), publishedAt: Date(), id: UUID()).makeJSON())})
        return JSON.array(logos)
    }

    func show(_ requ: Request, logo: Logo) throws -> ResponseRepresentable {
        return try logo.makeResponse()
    }

    func makeResource() -> Resource<Logo> {
        return Resource(index: index, create: nil, store: nil, show: show)
    }

    typealias Model = Logo
}
