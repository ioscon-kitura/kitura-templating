import Kitura
import LoggerAPI
import HeliumLogger
import KituraStencil

// Create a new router
let router = Router()

// Install the templating engine
router.setDefault(templateEngine: StencilTemplateEngine())
router.get("/talks") { _, response, next in
    defer {
        next()
    }
    do {
        var context: [String: Any] = [
            "talks": [
                [ "title": "Type-safe Web APIs with Protocol Buffers in Swift", "presenter": "Yusuke Kita" ],
                [ "title": "The Grand Tour of iOS Architectures", "presenter": "Dan Cutting" ],
                [ "title": "Building a server-side Swift app with the Kitura web framework", "presenter": "Chris Bailey and Ian Partridge" ],
            ]
        ]

        try response.render("talks", context: context).end()
    } catch {
        Log.error("Failed to render template \(error)")
    }
}

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("Hello, World!")
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()

