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

    let validIds = (1...6)

    func index(_ req: Request) throws -> ResponseRepresentable {
        var logos = [JSON]()

        validIds.map({
            let imageURL = try! req.uri.appendingPathComponent("storage/icon_120x120-\($0).png").makeFoundationURL()
            logos.append(try! Logo(thumbnailURL: imageURL,
                                   logoURL: nil,
                                   publishedAt: Date(),
                                   id: "\($0)").makeJSON())})
        return JSON.array(logos)
    }

    func show(_ req: Request, logo: Logo) throws -> ResponseRepresentable {
        dump(req.parameters)
        let id = Int(req.uri.lastPathComponent!)!
        guard validIds.contains(id) else { throw Abort(.notFound) }
        if id == 4 {
            return "<!DOCTYPE html><h2>Internal error. Contact support to resolve</h2>"
        }



        let logo = try! Logo(thumbnailURL: try! req.uri.removingPath().appendingPathComponent("/logos/storage/icon_120x120-\(id).png").makeFoundationURL(), logoURL: try! req.uri.removingPath().appendingPathComponent("/logos/storage/icon_1024x1024-\(id).png").makeFoundationURL(), publishedAt: Date(), id: "\(id)").makeJSON()
        return logo
    }

    func makeResource() -> Resource<Logo> {
        return Resource(index: index, create: nil, store: nil, show: show)
    }

    typealias Model = Logo
}
