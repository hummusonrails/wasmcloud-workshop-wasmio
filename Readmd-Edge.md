# Edge Deployment

CNCF's wasmCloud is platformed on top of CNCF's nats.io. Nats is a messaging platform that enables very different topologies from multi-cloud to edge.

In this workshop we will have a local wasmCloud instance connect to a remote instance from Codespace.


## Local Setup


Let's start by creating two different nats configuration in ./host and ./leaf

Host:
```
port: 4223
server_name: hub

jetstream {
  store_dir = "./hubjsdata"
  domain    = WADM

}

leafnodes: {
  port: 7422
}
```


Leaf:
```
port: 4222
server_name: leaf

jetstream {
  store_dir = "./leafjsdata"
  domain    = WADMLeaf
}

leafnodes: {
  remotes: [
    {
      url: ["nats-leaf://127.0.0.1:7422"],
    }
  ]
}

```

The block we are interested in is [leafnodes](https://wasmcloud.com/docs/deployment/nats/js-leaf/). The first one defines accepting connection on port 7422, the second one defines a new remote. The remote is the address of the host the leaf will connect to. Leafs are a fantastic nats feature that enables the different topologies. To work, it only requires a one way connection to the host, hence making it possible with codespace/gitpod.

Wash and nats allow you to run two different instances easily. With nats you need to specify a config file, host and port. With Wash you need to give the Nats conf and add the --multi-local flag:

To start playing, make sure wash is not running:

```
wash down
```

Now you can run the two following command
```
wash up   --nats-host 127.0.0.1 --nats-port 4223 --multi-local  --nats-config-file host

wash up   --nats-host 127.0.0.1 --nats-port 4222 --multi-local  --nats-config-file leaf
```

What this will do is start two different instances, two separate wasmCloud/Nats setup. You can make sure this works by typing

```
wash get hosts
```

You should see the two different hosts. Now to emulate what `wash dev` was doing, you can run from the `nubase` folder:

`wash app deploy ./local.wadm.yml`

This will deploy your application. Check out all the deployed provider, components and hosts with `wash get inventory`.

## Remote Setup

Now let's be a little more practical and connect to a remote server. We have a cluster running in the cloud on 34.56.193.181. This cluster is also expecting connection on port 7422.

Yes it's wide open, it's a workshop, security is a concern for a longer, oh much longer workshop.

Let's create a new nats config file in ./remoteLeaf and rerun only the leaf host


Remote Leaf:
```
port: 4222
server_name: leaf

jetstream {
  store_dir = "./leafjsdata"
  domain    = WADMLeaf
}

leafnodes: {
  remotes: [
    {
      url: ["nats-leaf://34.56.193.181:7422"],
    }
  ]
}

```

```
wash down
wash up   --nats-host 127.0.0.1 --nats-port 4222 --multi-local  --nats-config-file ./remoteLeaf
```

You should be connected to the remote cluster and can make sure of this with

```
wash get hosts
```

Time to have fun and start deploying components

