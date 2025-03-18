# Wasm I/O 2025: Getting Started with Wasmcloud

This repository contains everything you need to get started with the workshop:

## 👷 Workshop

In this workshop, we'll build two wasmCloud components:

1. **NuBase**, an experimental database powered by Couchbase and written in Go.

2. A simple HTTP server written in Rust, responding with a friendly greeting.

By the end of the workshop, we will:

- Examine the HTTP & Couchbase native WebAssembly Interface Type ("WIT") interfaces
- Build a HTTP API [WebAssembly-native database component][wasmcloud-docs-component], powered by [Couchbase][couchbase] in Go
- Build a HTTP server component in Rust
- Run your database implementation locally with [wasmCloud][wasmcloud]

[wasmcloud-docs-component]: https://wasmcloud.com/docs/concepts/components
[wasmCloud]: https://wasmcloud.com

## 📂 Organization

Here's a run-down of the files in this repository:

| Folder            | Description                                                           |
|-------------------|-----------------------------------------------------------------------|
| `wit`             | WIT definitions we'll be using during the talk                        |
| `nubase`          | Code for the Database component we'll finish as part of this workshop |
| `hello`     | Code for the HTTP server we'll build as part of this workshop         |

## 🌎 Environment setup

### GitPod

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/hummusonrails/wasmcloud-workshop-wasmio)

If using [GitPod][gitpod], you can launch `.gitpod.yml` file in this repository, and make an account at GitPod.io if necessary to get into an environment that "just works"!

[gitpod]: https://gitpod.io

### GitHub Codespaces

[![Open in Codespaces](https://img.shields.io/badge/Open%20in-GitHub%20Codespaces-blue?logo=github&logoColor=white&style=for-the-badge)](https://codespaces.new/hummusonrails/wasmcloud-workshop-wasmio/tree/workshop)

If using GitHub Codespaces, just click on the button above, and if you already have a GitHub account, you can get into an environment that "just works"!

> [!NOTE]  
> This link will open a Codespace in the `workshop` branch, which is the branch that contains incomplete code that we'll be building during the workshop. 

### Devcontainers

To use [GitHub devcontainers][devcontainers] to run this project, you can run

```console
just start-devcontainer
```

> [!NOTE]
> If you prefer to *not* use [`just`][just], run `devcontainer up --workspace-folder .`
>
> See [`Justfile`](./Justfile) for more recipes and the commands they run.

[devcontainers]: https://github.com/devcontainers/cli

### Manual/Local

To run manually, ensure that you have the following tools installed:

| Dependency                 | Description                                               | Easy install method                            |
|----------------------------|-----------------------------------------------------------|------------------------------------------------|
| [`just`][just]             | Task runner (similar to GNU `make`)                       | `cargo install just`                           |
| [`wash`][wash]             | WAsmcloud SHell - a tool for managing wasmCloud instances | `cargo install wash-cli`                       |
| [`wit-deps`][wit-deps]     | Manual downloading of WIT interfaces                      | `cargo install wit-deps-cli`                   |
| [`wasm-tools`][wasm-tools] | WebAssembly toolkit (used during code generation)         | `cargo install wasm-tools`                      |
| [`tinygo`][tinygo]         | [TinyGo][tinygo] toolchain                                | [`tingyo` install guide][tinygo-install-guide] |
| [`go`][go]                 | [Go][go] toolchain                                        | [`go` install guide][go-install-guide]         |
| ['rust'][rust]               | [Rust][rust] toolchain                                  | [`rust` install guide][rust-install-guide]     |

[just]: https://github.com/casey/just
[wash]: https://wasmcloud.com/docs/installation
[tinygo]: https://tinygo.org/
[go]: https://go.dev/
[rust]: https://www.rust-lang.org/
[rust-install-guide]: https://www.rust-lang.org/tools/install
[wit-deps]: https://github.com/bytecodealliance/wit-deps
[wasm-tools]: https://github.com/bytecodealliance/wasm-tools
[tinygo-install-guide]: https://tinygo.org/getting-started/install/
[go-install-guide]: https://go.dev/learn/

You can easily check which tools are not installed by running:

```console
just check
```

Once you have all required tools installed, you can build the project by running:

```console
just build
```

Then, start Couchbase, using `docker compose`:

```console
just start-couchbase
```

Deploy individual components using `wash`:

```console
wash app deploy /path/to/component/wadm.yaml
```

From here, you can start developing the component:

```console
just dev
```
