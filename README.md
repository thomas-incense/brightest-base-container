# Brightest base container

This is the base container for Brightest app. It has all the dependcies install with correct versions.

## Reference

#### Build command

```
  docker build . -t brightest-base-container --platform linux/amd64
```

#### Tag command

```
  docker tag brightest-base-container ghcr.io/brightest/base-container
```

#### Push Command

```
  docker push ghcr.io/brightest/base-container
```
