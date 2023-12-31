# Apache Jena Fuseki

Docker build file for running a container with [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/) including UI. All Fuseki CLI parameters documented in the [Fuseki Docker](https://jena.apache.org/documentation/fuseki2/fuseki-main#fuseki-docker) project should work, but I use this image only for serving local files.

## Apache Jena
Next to Fuseki, this image also contains the Jena, containing the APIs, SPARQL engine, the TDB native RDF database and command line tools. This is not needed to run Fuseki (the Jena SPARQL server), but convineant to create TDB2 databases and other usage of the [Jena CLI tools](https://jena.apache.org/documentation/tools/).

## Build
```bash
docker buildx build -t mlindeman/fuseki .
```

## Run container
Assuming you have a file `data/example.ttl` (this example file is available in this repo):

```bash
docker run --rm -p 3030:3030 \
  -v $PWD/data:/usr/share/data mlindeman/fuseki \
  --file=/usr/share/data/example.ttl /ds
```

After startup, your dataset should be available with UI on http://localhost:3030/#/dataset/ds/query

## Create a TDB2 RDF Store
To create a [TDB2](https://jena.apache.org/documentation/tdb2/) from  your local RDF files, use a one time container to run of of the Jena CLI tools (in this case `tdb2.tdbloader`). See this example that will create a `tsb2` RDF Store from the `example.ttl` file:
```bash
docker run -it --rm -v $PWD/data:/data \
  --entrypoint tdb2.tdbloader \
  mlindeman/fuseki --loc=/data/tdb2 /data/example.ttl
```

After you have created the `tdb2` store, you can start Fuseki with it:
```bash
docker run --rm -p 3030:3030 \
  -v $PWD/tdb2:/tdb2 mlindeman/fuseki \
  --loc=/tdb2 /ds
```