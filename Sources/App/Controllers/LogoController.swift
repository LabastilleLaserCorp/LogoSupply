//
//  LogoController.swift
//  LogoSupplyPackageDescription
//
//  Created by Seán Labastille on 15.11.17.
//

import Vapor
import HTTP

final class LogoController: ResourceRepresentable, EmptyInitializable {

    func index(_ req: Request) throws -> ResponseRepresentable {
        throw Abort(.notImplemented)
    }

    func show(_ requ: Request, logo: Logo) throws -> ResponseRepresentable {
        return try logo.makeResponse()
    }

    func makeResource() -> Resource<Logo> {
        return Resource(index: index, create: nil, store: nil, show: show)
    }

    typealias Model = Logo
}
