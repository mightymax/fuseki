# Apache Jena Fuseki

Docker build file for running a very basic container with [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/) including UI. All Fuseki CLI parameters should work, but I use this image only for serving local files.

## Build
```
docker buildx build -t mlindeman/fuseki .
```

## Run container
Assuming you have a file `/tmp/rdf/data.ttl`:

```
docker run --rm -p 3030:3030 \
  -v /tmp/rdf:/usr/share/data mlindeman/fuseki \
  --file=/usr/share/data/data.ttl /ds
```

After startup, your dataset should be available with UI on http://localhost:3030/#/dataset/ds/query

