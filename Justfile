just := env_var_or_default("JUST", just_executable())
wash := env_var_or_default("WASH", "wash")
docker := env_var_or_default("DOCKER", "docker")
go := env_var_or_default("GO", "go")
tinygo := env_var_or_default("TINYGO", "tinygo")
wit-deps := env_var_or_default("WIT_DEPS", "wit-deps")
wasm-tools := env_var_or_default("WASM_TOOLS", "wasm-tools")
devcontainer := env_var_or_default("DEVCONTAINER", "devcontainer")

devcontainer_container_name := env_var_or_default("DEVCONTAINER_CONTAINER_NAME", "kcon2024-workshop")

couchbase_docker_image := env_var_or_default("COUCHBASE_DOCKER_IMAGE", "couchbase:7.6.3@sha256:78446fa1cf1c9cea6c563114b7882b5c3f84d1663207b15dd966bf8f10b427c0")

@_default:
    {{just}} --list

# Ensure `wash` tooling is present
@_ensure-tool-wash:
    command -v {{wash}} || echo "wash binary is missing/not on your PATH, please install it (see: https://wasmcloud.com/docs/installation)"

# Ensure `docker` tooling is present
@_ensure-tool-docker:
    command -v {{docker}} || echo "docker binary is missing/not on your PATH, please install it (see: https://docs.docker.com/get-started/get-docker/)"

# Ensure `devcontainer` tooling is present
@_ensure-tool-devcontainer:
    command -v {{devcontainer}} || echo "devcontainer binary is missing/not on your PATH, please install it (see: https://github.com/devcontainers/cli)"

# Ensure `wit-deps` tooling is present
@_ensure-tool-wit-deps:
    command -v {{wit-deps}} || echo "wit-deps binary is missing/not on your PATH, please install it (see: https://github.com/bytecodealliance/wit-deps)"

# Ensure `tinygo` tooling is present
@_ensure-tool-tinygo:
    command -v {{tinygo}} || echo "tinygo binary is missing/not on your PATH, please install it (see: https://tinygo.org/getting-started/install/)"

# Ensure `go` tooling is present
@_ensure-tool-go:
    command -v {{go}} || echo "go binary is missing/not on your PATH, please install it (see: https://go.dev)"

# Ensure `wasm-tools` tooling is present
@_ensure-tool-wasm-tools:
    command -v {{wasm-tools}} || echo "wasm-tools binary is missing/not on your PATH, please install it (see: https://github.com/bytecodealliance/wasm-tools)"

###############
# Environment #
###############

# Check for required tools
check: _ensure-tool-wash _ensure-tool-docker _ensure-tool-tinygo _ensure-tool-go _ensure-tool-wasm-tools

# Start the local devcontainer
start-devcontainer: _ensure-tool-devcontainer
    {{devcontainer}} up --workspace-folder .

# Stop the local devcontainer
stop-devcontainer: _ensure-tool-docker
    {{docker}} stop {{devcontainer_container_name}}
    {{docker}} rm {{devcontainer_container_name}}

##################
# Infrastructure #
##################

couchbase_container_name := "couchbase"

# Start the couchbase cluster
start-couchbase:
    {{docker}} compose -f docker-compose.yml up

# Stop the local couchbase cluster
stop-couchbase:
    {{docker}} compose -f docker-compose.yml down

# Clear out the local couchbase cluster
clear-couchbase:
    {{docker}} compose -f docker-compose.yml rm
    {{docker}} volume rm wasmcon2024-couchbase-workshop_couchbase-data

#########
# Build #
#########

# Fetch WIT interfaces
fetch-wit:
    {{wit-deps}} && {{wit-deps}} update

# Build the `nubase` WebAssembly component
build: _ensure-tool-wash fetch-wit
    {{wash}} build -p nubase/wasmcloud.toml

# Start `wash dev` to dynamically develop the `nubase` WebAssembly component
dev: _ensure-tool-wash fetch-wit
    cd nubase && {{wash}} dev

hello-build:
    cd hello && cargo build --release --target wasm32-wasi