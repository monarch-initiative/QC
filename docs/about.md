### Purpose
Community facing documentation about quality control (QC) for the entire Monarch stack.

### Monarch components - QC and workflow

#### Dipper: data ingestion/ETL pipeline (pre-QC)

Dipper ingests data from [many different remote sources](https://beta.monarchinitiative.org/about/data-sources).

Ingestion of data from remote sources into the Monarch stack is configured as a
[Jenkins pipeline](https://ci.monarchinitiative.org/blue/organizations/jenkins/dipper-pipeline/activity/)
that runs [Dipper](https://github.com/monarch-initiative/dipper) on a regular basis and records output,
error messages, and runtime failures. Failures and errors are addressed with fairly frequent updates to the Dipper
codebase.

The bleeding edge ingested and transformed data (that have not passed the QC process) along with metadata about the ingested
data are output as [rdf](https://data.monarchinitiative.org/ttl/).

#### [Monarch data releases](https://archive.monarchinitiative.org) (post-QC)

A critical aspect of data ingest is confirming the data ingested are fit for purpose. With many 
heterogeneous sources updating their data, their data formats, their data servers, their data 
licenses, keeping the ingestion running is a Sisyphean endeavor. 

When hundreds of million statements are successfully produced, questions abound: What do they contain?
How do they compare with previous releases? What is new? What went away? What caused these changes?
Does the output conform to the intended model?

To confirm that data are fit for purpose, the Monarch team periodically performs an extensive QC
process on the data output by Dipper. 

This process includes the following steps:
- data output from Dipper are loaded into a new [Scigraph instance](https://github.com/monarch-initiative/scigraph-docker)
- a comparison of the contents of new Scigraph instance and existing production SciGraph instance is [performed](https://github.com/monarch-initiative/release-utils/blob/master/scripts/monarch-count-diff.py)
- the results are manually inspected, and large discrepancies between the two SciGraph instances are investigated for 
possible issues (see [here](https://archive.monarchinitiative.org/201909/qc/monarch-diff-201909061129.html) for an example
diff result)
- a "visual reduction" is performed to output a graphical representation of the new data, as well what has changed from the previous release ([example](https://archive.monarchinitiative.org/201908/visual_reduction/))

When the data pass this QC process, they are output into 
the [Monarch Data Archive](https://archive.monarchinitiative.org) as a new data release. These
occur approximately once every few months. These data releases include:
- rdf files for each data ingested from each source ([example](https://archive.monarchinitiative.org/201909/rdf))
- owl files for each ontology ingested ([example](https://archive.monarchinitiative.org/201909/owl))
- a detailed QC report with an itemized list of changes between the current and previous release ([example](https://archive.monarchinitiative.org/201909/qc))


### Contact
For questions, please contact [info@monarchinitiative.org](mailto:info@monarchinitiative.org).
