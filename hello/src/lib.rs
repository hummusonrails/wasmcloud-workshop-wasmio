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

// - Think about what you would do differently in this file. 
//   For example, how would you handle different HTTP methods (GET, POST, etc.)?
// - What features would you add to this HTTP server? 
//   Consider adding routing to handle different paths or query parameters.
// - How could you leverage the fact that this is part of a wasmCloud host in the HTTP provider?
//   For instance, you could use capabilities like key-value storage, messaging, or even interact with other actors.
// - How would you handle error cases or return different status codes?
// - Consider adding logging to help with debugging and monitoring.
