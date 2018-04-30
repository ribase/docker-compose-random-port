# Docker Compose with random ports

## Why?

Ever thought that maybe running several projects with docker is nice to have.

Ya well...but docker itself can't bind random port or iterate over ports until the next one is free

### Solution

In this repo you will find a script that determine the next port starting at `:80`.

### Usage

Clone this project and `cd` into it.

After just type `./start-local-server` and hit enter.

It will start to search from port 80 up to the next free port.

#### Be more advanced

If you think - bahh i dont like port 80, port is to default - thats no problem at all.

As you can see above its possible to pass custom ports as well.

```
./start-local-server 8080 33069
```

The first port is the port for http applications and the other one is for mysql or other applications, but in this example mysql is a good value.

### Credits

Sebastian Thadewald

### License

See Licensefile