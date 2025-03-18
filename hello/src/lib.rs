use wasmcloud_component::http;

struct Component;

// Export the actor by passing your component type to the macro.
http::export!(Component);

// Implement the HTTP server interface for your component.
impl http::Server for Component {
    fn handle(
        _request: http::IncomingRequest,
    ) -> http::Result<http::Response<impl http::OutgoingBody>> {
        // Return a simple greeting message.
        Ok(http::Response::new("Hello, wasmCloud!\n"))
    }
}
