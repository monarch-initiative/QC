### Dipper

#### About
Dipper QC reduces monarch triples into sets of namespace - predicate - namespace triples.
These triples are can be viewed in three types of network graphs, and a table.

#### Namespace network - release
Monochromatic representation of every namespace transition (statement type) found in each ingest.
Numbers on edges represent total count for the type of statement.

#### Namespace network - changes

Graphical depiction of every namespace level difference from the previous release to this release.
Numbers on edges represent changes in counts for the type of statement:  
- blue represents newly added edges
- orange represents an old edges no longer present.
- black is continuing at the same volume or more
- pink is continuing but at a decreased amount

Also available as a [table](namespace-table.html)

#### Namespace network - reduced

This set is not a complete representation of the ingest as the other two are.
Here accuracy is exchanged for emphasizing greatest RELATIVE difference.
There are no edge counts displayed, instead edge width scales with
greatest absolute difference in counts between previous and current release.
Furthermore the change in counts must be more than "several" to be considered
significant enough to include at all, so unchanged parts of the graph fade away.
    
Caveats when interpreting these 'reduced' graphs include:
- the width of an edge has nothing to do with any other graph
- the width of an edge has nothing to do with the count of edges in its graph.

The width of an edge only approximates its relative portion of the largest difference
observed in the corresponding network changes graph.
