# Apache Jena Fuseki

Docker build file for running a container with [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/) including UI. All Fuseki CLI parameters documented in the [Fuseki Docker](https://jena.apache.org/documentation/fuseki2/fuseki-main#fuseki-docker) project should work, but I use this image only for serving local files.

## Apache Jena
Next to Fuseki, this image also contains the Jena, containing the APIs, SPARQL engine, the TDB native RDF database and command line tools. This is not needed to run Fuseki (the Jena SPARQL server), but convineant to create TDB2 databases and other usage of the [Jena CLI tools](https://jena.apache.org/documentation/tools/).

## Build
```
docker buildx build -t mlindeman/jena:5.1.0 .
docker tag mlindeman/jena:5.1.0 mlindeman/jena:latest
```

## Run Fuseki server
The image contains an example file of episodes from the TV Series "The Big Bang Theory", using (mainly) the schema.org vocabulary. You can use this example to run a Fuseki server using the following command:
```bash
docker run --rm -p 3030:3030 mlindeman/jena tbbt
```

The dataset can now be queried at http://localhost:3030/#/dataset/tbtt/query.

An example query would be:
```SPARQL
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix sdo: <https://schema.org/>
prefix season: <https://ex.com/the-big-bang-theory/season/>

SELECT ?title ?datePublished
WHERE {
  ?episode a sdo:TVEpisode ; 
  	sdo:name ?title ; 
   	sdo:partOfSeason season:1 ;
    sdo:datePublished ?datePublished
  .
} order by ?episodeNumber
```

To run Fuseki using your own data, use something like this (assuming you have a file `./rdf/example.ttl`):
```bash
docker run --rm -p 3030:3030 \
  -v `pwd`/rdf:/data mlindeman/jena \
  fuseki --file=/data/example.ttl /example
```
The dataset can now be queried at http://localhost:3030/example.

After startup, your dataset should be available with UI on http://localhost:3030/#/dataset/ds/query

## Other jena tooling
The full set of [Command-line and other tools for Jena developers](https://jena.apache.org/documentation/tools/index.html) is also availble in this image.

## Common tasks:

### Validate RDF for syntax errors:
```bash
docker run -v `pwd`/examples/:/rdf mlindeman/jena sh -c "riot --validate /rdf/*.ttl"
```

### Validate RDF against a [SHACL model](https://www.w3.org/TR/shacl):
```bash
docker run --rm -v `pwd`/examples:/rdf mlindeman/jena shacl v --shapes /rdf/model.ttl --data /rdf/tbbt.ttl
```

### Transform RDF to another format:
```bash
docker run -v `pwd`/examples/:/rdf mlindeman/jena rdfxml --out nt /rdf/tbbt.ttl
```
