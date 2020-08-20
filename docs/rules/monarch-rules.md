## Monarch Rules
### Gene and Disease are disjoint
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Agene%29+WHERE+n%3Adisease+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+gene)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Agene%29+WHERE+n%3Adisease+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+gene)

| field | count |
|-|-|
| gene | 2 (0) |


### Variant and Disease are disjoint
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Avariant%29+WHERE+n%3Adisease+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+variant)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Avariant%29+WHERE+n%3Adisease+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+variant)

| field | count |
|-|-|
| variant | 9 (+__1__) |


### Gene and Variant are disjoint
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Avariant%29+WHERE+n%3Agene+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+variant)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Avariant%29+WHERE+n%3Agene+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+variant)

| field | count |
|-|-|
| variant | 5446 (+__3058__) |


### Disease and Phenotype are disjoint
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Adisease%29+WHERE+n%3Aphenotype+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+disease)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%3Adisease%29+WHERE+n%3Aphenotype+AND+n%3AcliqueLeader+RETURN+COUNT%28DISTINCT%28n%29%29+as+disease)

| field | count |
|-|-|
| disease | 22 (0) |


### Genes in more than one taxa (pass inferred)
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28taxon1%29%3C-%5B%3ARO%3A0002162%5D-%28n%3Agene%29-%5B%3ARO%3A0002162%5D-%3E%28taxon2%29%0AWHERE+%28n%3AcliqueLeader%29+AND+taxon1+%3C%3E+taxon2+AND+NOT+%28taxon1%29-%5B%3AsubClassOf%5D-%28taxon2%29%0ARETURN+DISTINCT%28COUNT%28n%29%29+as+genes%0A)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28taxon1%29%3C-%5B%3ARO%3A0002162%5D-%28n%3Agene%29-%5B%3ARO%3A0002162%5D-%3E%28taxon2%29%0AWHERE+%28n%3AcliqueLeader%29+AND+taxon1+%3C%3E+taxon2+AND+NOT+%28taxon1%29-%5B%3AsubClassOf%5D-%28taxon2%29%0ARETURN+DISTINCT%28COUNT%28n%29%29+as+genes%0A)

| field | count |
|-|-|
| genes | 4244 (0) |


### Genes in more than one taxa (fail inferred)
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28taxon1%29%3C-%5B%3ARO%3A0002162%5D-%28n%3Agene%29-%5B%3ARO%3A0002162%5D-%3E%28taxon2%29%0AWHERE+%28n%3AcliqueLeader%29+AND+taxon1+%3C%3E+taxon2%0ARETURN+DISTINCT%28COUNT%28n%29%29+as+genes%0A)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28taxon1%29%3C-%5B%3ARO%3A0002162%5D-%28n%3Agene%29-%5B%3ARO%3A0002162%5D-%3E%28taxon2%29%0AWHERE+%28n%3AcliqueLeader%29+AND+taxon1+%3C%3E+taxon2%0ARETURN+DISTINCT%28COUNT%28n%29%29+as+genes%0A)

| field | count |
|-|-|
| genes | 11392 (+__1636__) |


### Genes with no taxon
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28gene%3Agene%29%0AWHERE+NOT+%28gene%29-%5B%3ARO%3A0002162%5D-%3E%28%29+AND+%28gene%3AcliqueLeader%29%0ARETURN+COUNT%28DISTINCT%28gene%29%29+as+genes%0A)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28gene%3Agene%29%0AWHERE+NOT+%28gene%29-%5B%3ARO%3A0002162%5D-%3E%28%29+AND+%28gene%3AcliqueLeader%29%0ARETURN+COUNT%28DISTINCT%28gene%29%29+as+genes%0A)

| field | count |
|-|-|
| genes | 413166 (+__61219__) |


### Features with no taxon
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28feature%3A%60sequence+feature%60%29%0AWHERE+NOT+%28feature%29-%5B%3ARO%3A0002162%5D-%3E%28%29+AND+%28feature%3AcliqueLeader%29%0ARETURN+COUNT%28DISTINCT%28feature%29%29+as+features%0A)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28feature%3A%60sequence+feature%60%29%0AWHERE+NOT+%28feature%29-%5B%3ARO%3A0002162%5D-%3E%28%29+AND+%28feature%3AcliqueLeader%29%0ARETURN+COUNT%28DISTINCT%28feature%29%29+as+features%0A)

| field | count |
|-|-|
| features | 4654808 (+__63543__) |


### Direct human gene to phenotype across RO has phenotype (number of genes)
[Production Query](https://scigraph-data.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28z%3ANode%7Biri%3A%27NCBITaxon%3A9606%27%7D%29%3C-%5B%3ARO%3A0002162%5D-%28n%3Agene%29-%5B%3ARO%3A0002200%5D-%3E%28x%3Aphenotype%29%0ARETURN+COUNT%28DISTINCT%28n.iri%29%29+as+genes%0A)

[Dev Query](https://scigraph-data-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28z%3ANode%7Biri%3A%27NCBITaxon%3A9606%27%7D%29%3C-%5B%3ARO%3A0002162%5D-%28n%3Agene%29-%5B%3ARO%3A0002200%5D-%3E%28x%3Aphenotype%29%0ARETURN+COUNT%28DISTINCT%28n.iri%29%29+as+genes%0A)

| field | count |
|-|-|
| genes | 13 (0) |


### Number of edges connected to owl:Nothing
[Production Query](https://scigraph-ontology.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28nothing%3ANode%7Biri%3A%27http%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23Nothing%27%7D%29-%5Brel%5D-%28n%29%0ARETURN+COUNT%28DISTINCT%28rel%29%29+as+nothing%0A)

[Dev Query](https://scigraph-ontology-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28nothing%3ANode%7Biri%3A%27http%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23Nothing%27%7D%29-%5Brel%5D-%28n%29%0ARETURN+COUNT%28DISTINCT%28rel%29%29+as+nothing%0A)

| field | count |
|-|-|
| nothing | 0 (0) |


### nodes with subClassOf cycles (depth 2)
[Production Query](https://scigraph-ontology.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%29-%5B%3AsubClassOf%2A2%5D-%3E%28n%29+RETURN+COUNT%28DISTINCT%28n%29%29+as+node_count)

[Dev Query](https://scigraph-ontology-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%29-%5B%3AsubClassOf%2A2%5D-%3E%28n%29+RETURN+COUNT%28DISTINCT%28n%29%29+as+node_count)

| field | count |
|-|-|
| node_count | 1 (0) |


### nodes with subClassOf cycles (depth 1)
[Production Query](https://scigraph-ontology.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%29-%5B%3AsubClassOf%5D-%3E%28n%29+RETURN+COUNT%28DISTINCT%28n%29%29+as+node_count)

[Dev Query](https://scigraph-ontology-dev.monarchinitiative.org/scigraph/cypher/execute.json?cypherQuery=MATCH+%28n%29-%5B%3AsubClassOf%5D-%3E%28n%29+RETURN+COUNT%28DISTINCT%28n%29%29+as+node_count)

| field | count |
|-|-|
| node_count | 2 (0) |


