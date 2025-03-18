# 👋 Hello Actor

Hello Actor is a simple WebAssembly component that responds with a greeting message via HTTP.

This [WebAssembly Component][wasm-components] `import`s the `wasmcloud:http/server` interface and makes that functionality available via HTTP by exporting the [WASI][wasi] standard [`wasi:http/incoming-handler`][wasi-http].

[wasm-components]: https://component-model.bytecodealliance.org/
[wasi]: https://wasi.dev
[wasi-http]: https://github.com/WebAssembly/wasi-http

### 📚 Hello Actor HTTP API

Hello Actor's API is straightforward, exposing a single endpoint:

| API endpoint          | Description                        |
|-----------------------|------------------------------------|
| `GET /`               | Returns a simple greeting message  |

## 📦 Dependencies

| Tool         | Description                                                             |
|--------------|-------------------------------------------------------------------------|
| `wash`       | [WAsmcloud][wasmcloud] SHell, a tool for running WebAssembly components |

[wasmcloud]: https://wasmcloud.com/docs
[wash]: https://wasmcloud.com/docs/ecosystem/wash/

## 👟 Quickstart

### Setup

Once you have the relevant dependencies installed, you start by buiding this component using [`wash build`][wash-dev], a subcommand of the WAsmcloud SHell:

```bash
wash build
```

After running `wash build`, you'll have a built WebAssembly component in the `build` directory at `./build/hello_s.wasm`. You will use that to deploy this component to your wasmCloud instance.

You deploy this component by running `wash app deploy wadm.yaml` from inside the folder of the component. Once you do so, you'll *automatically* have access to a [wasmCloud provider][wasmcloud-docs-provider] which starts a local HTTP server that you can use to access this component.

## Local Usage Guide

Once `wash app deploy` has finished, you should be able to simply `curl` this component:

```console
curl localhost:8000/
```

You should receive the following response:

```plaintext
Hello, wasmCloud!
```

[wasmcloud-docs-provider]: https://wasmcloud.com/docs/concepts/providers
[wash-dev]: https://wasmcloud.com/docs/cli/#wash-build