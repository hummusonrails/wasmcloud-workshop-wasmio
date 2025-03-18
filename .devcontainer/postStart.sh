#!/bin/sh

# Some debugging of the path
echo "CARGO_HOME is: $CARGO_HOME"
echo "PATH is: $PATH"
echo "Location of 'just' using which: $(which just)"
echo "Location of 'just' using command -v: $(command -v just)"

# Export the PATH
export PATH=/home/gitpod/.cargo/bin:/workspace/.cargo/bin:$PATH


# Start Couchbase server
sudo /entrypoint.sh couchbase-server &

# Wait for the server to start
sleep 30

# Run Couchbase shell commands
cbsh -c "source bucketSetup.nu; dbSetup $COUCHBASE_DEFAULT_BUCKET $COUCHBASE_DEFAULT_SCOPE $COUCHBASE_DEFAULT_COLLECTION"

# Start the development environment
just dev