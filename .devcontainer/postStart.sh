#!/bin/sh

# Export the PATH
export PATH=/home/attendee/.cargo/bin:$PATH

# Start Couchbase server
sudo /entrypoint.sh couchbase-server &

# Wait for the server to start
sleep 30

# Run Couchbase shell commands
cbsh -c "source bucketSetup.nu; dbSetup $COUCHBASE_DEFAULT_BUCKET $COUCHBASE_DEFAULT_SCOPE $COUCHBASE_DEFAULT_COLLECTION"

# Start the development environment
just dev