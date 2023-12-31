# Apache Jena Fuseki

Docker build file for running a very basic container with [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/) including UI. All Fuseki CLI parameters should work, but I use this image only for serving local files.

## Build
```
docker buildx build -t mightymax/fuseki .
```

## Run container
Assuming you have a file `data/example.ttl` (this example file is available in this repo):

```
docker run --rm -p 3030:3030 \
  -v $PWD/data:/usr/share/data mlindeman/fuseki \
  --file=/usr/share/data/example.ttl /ds
```

After startup, your dataset should be available with UI on http://localhost:3030/#/dataset/ds/query

