# CI

This is a work in progress.

## Local Development

You can currently get Enterprise Search running locally with docker-compose, run `docker-compose up` from this directory to get everything set up. You need to set the value of `REVISION` in your environment:

```bash
$ REVISION=7.7.0 docker-compose up
```

You can check it's working with:
```bash
curl -u elastic:changeme http://localhost:8080/swiftype-app-version
```
