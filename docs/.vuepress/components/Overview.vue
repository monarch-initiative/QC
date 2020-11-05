<template>
  <div>
    <hr>

    <div class="scigraph-version">
      <div v-show="!versionFetched" class="overview-spinner">
        <b-spinner
          class="loading-spinner"
          type="grow"
          label="Loading"
        />
      </div>
      Production build: <a :href="prodVersion" target="_blank">{{prodVersion}}</a>
      <br>
      Beta build: <a :href="devVersion" target="_blank">{{devVersion}}</a>
    </div>

    <div class="chart-title">Phenotype Associations By Source (Solr)</div>

    <b-form-group>
      <b-form-radio-group
        id="phenotype-val-radios"
        v-model="phenotypeValue"
        v-on:input="updateSolrData(
          phenotypeValue, phenotypeQualifier, phenotypeAssociations, 'phenotype-heatmap')"
        :options="solrValueOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <b-form-group>
      <b-form-radio-group
        id="phenotype-qual-radios"
        v-model="phenotypeQualifier"
        v-on:input="updateSolrData(
          phenotypeValue, phenotypeQualifier, phenotypeAssociations, 'phenotype-heatmap')"
        :options="qualifierOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <div v-show="!phenotypesFetched" class="overview-spinner">
      <b-spinner
        class="loading-spinner"
        type="grow"
        label="Loading"
      />
    </div>

    <div id="phenotype-heatmap" class="chart"></div>

    <div class="chart-title">Disease Associations By Source (Solr)</div>

    <b-form-group>
      <b-form-radio-group
        id="disease-val-radios"
        v-model="diseaseValue"
        v-on:input="updateSolrData(
          diseaseValue, diseaseQualifier, diseaseAssociations, 'disease-heatmap')"
        :options="solrValueOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <b-form-group>
      <b-form-radio-group
        id="disease-qual-radios"
        v-model="diseaseQualifier"
        v-on:input="updateSolrData(
          diseaseValue, diseaseQualifier, diseaseAssociations, 'disease-heatmap')"
        :options="qualifierOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <div v-show="!diseasesFetched" class="overview-spinner">
      <b-spinner
        class="loading-spinner"
        type="grow"
        label="Loading"
      />
    </div>

    <div id="disease-heatmap" class="chart"></div>

    <div class="chart-title">Publication Associations By Source (Solr)</div>

    <b-form-group>
      <b-form-radio-group
        id="publication-val-radios"
        v-model="publicationValue"
        v-on:input="updateSolrData(
          publicationValue, publicationQualifier, publicationAssociations, 'publication-heatmap')"
        :options="solrValueOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <b-form-group>
      <b-form-radio-group
        id="publication-qual-radios"
        v-model="publicationQualifier"
        v-on:input="updateSolrData(
          publicationValue, publicationQualifier, publicationAssociations, 'publication-heatmap')"
        :options="qualifierOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <div v-show="!publicationsFetched" class="overview-spinner">
      <b-spinner
        class="loading-spinner"
        type="grow"
        label="Loading"
      />
    </div>

    <div id="publication-heatmap" class="chart"></div>

    <div class="chart-title">Other Associations By Source (Solr)</div>

    <b-form-group>
      <b-form-radio-group
        id="other-val-radios"
        v-model="otherValue"
        v-on:input="updateSolrData(
          otherValue, otherQualifier, otherAssociations, 'other-heatmap')"
        :options="solrValueOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <b-form-group>
      <b-form-radio-group
        id="other-qual-radios"
        v-model="otherQualifier"
        v-on:input="updateSolrData(
          otherValue, otherQualifier, otherAssociations, 'other-heatmap')"
        :options="qualifierOptions"
        size="sm"
        buttons
        name="radios-btn-default"
      ></b-form-radio-group>
    </b-form-group>

    <div v-show="!otherFetched" class="overview-spinner">
      <b-spinner
        class="loading-spinner"
        type="grow"
        label="Loading"
      />
    </div>

    <div id="other-heatmap" class="chart"></div>
  </div>

</template>

<script>
  import Plotly from 'plotly.js-dist';
  import axios from 'axios';
  import path from 'path';

  export default {
    components: {},
    props: {},
    data() {
      return {
        solrData: null,
        solrDataDirect: null,
        devVersion: null,
        prodVersion: null,
        phenotypeValue: 'percent',
        diseaseValue: 'percent',
        publicationValue: 'percent',
        otherValue: 'percent',
        phenotypeQualifier: 'all',
        diseaseQualifier: 'all',
        publicationQualifier: 'all',
        otherQualifier: 'all',
        qualifierOptions: [
          { text: 'Direct+Inferred', value: 'all' },
          { text: 'Direct Only', value: 'direct' },
        ],
        solrValueOptions: [
        { text: 'Percent change', value: 'percent' },
        { text: 'Beta counts', value: 'dev' },
        { text: 'Production counts', value: 'production' }
      ],
        phenotypesFetched: false,
        diseasesFetched: false,
        publicationsFetched: false,
        otherFetched: false,
        versionFetched: false,
        phenotypeAssociations: [
          'case_phenotype',
          'genotype_phenotype',
          'variant_phenotype',
          'disease_phenotype',
          'gene_phenotype',
        ],
        diseaseAssociations: [
          'model_disease',
          'genotype_disease',
          'variant_disease',
          'disease_pathway',
          'disease_phenotype',
          'marker_disease',
          'gene_disease',
          'chemical_disease',
        ],
        publicationAssociations: [
          'publication_model',
          'publication_genotype',
          'publication_variant',
          'publication_gene',
          'publication_disease',
          'publication_phenotype',
        ],
        otherAssociations: [
          'pathway_phenotype',
          'case_variant',
          'case_genotype',
          'case_gene',
          'variant_genotype',
          'variant_gene',
          'genotype_gene',
          'model_case',
          'model_genotype',
          'model_variant',
          'model_gene',
          'gene_anatomy',
          'gene_function',
          'gene_pathway',
          'gene_interaction',
          'gene_homology',
        ]
      }
    },
    mounted: async function() {

      // no idea why, but this makes the page load faster
      await new Promise(r => setTimeout(r, 0));

      let selected = 'percent';

      await this.getSciGraphVersion();
      this.versionFetched = true;

      const solrData = await this.getSolrPivot();

      if (this.devVersion === this.prodVersion) {
        selected = 'production';
        this.phenotypeValue = 'production';
        this.diseaseValue = 'production';
        this.publicationValue = 'production';
        this.otherValue = 'production';
      }

      this.makeHeatMap(solrData, this.phenotypeAssociations, 'phenotype-heatmap', selected);
      this.phenotypesFetched = true;

      this.makeHeatMap(solrData, this.diseaseAssociations, 'disease-heatmap', selected);
      this.diseasesFetched = true;

      this.makeHeatMap(solrData, this.publicationAssociations, 'publication-heatmap', selected);
      this.publicationsFetched = true;

      this.makeHeatMap(solrData, this.otherAssociations, 'other-heatmap', selected);
      this.otherFetched = true;
    },
    methods: {

      async getSciGraphVersion() {
        const sessionStorage = window.sessionStorage;

        if (this.prodVersion === null && sessionStorage.getItem('prodVersion') === null) {
          const [devVersion, prodVersion] = await this.fetchSciGraphVersion();
          this.devVersion = devVersion;
          this.prodVersion = prodVersion;
          sessionStorage.setItem('devVersion', JSON.stringify(devVersion));
          sessionStorage.setItem('prodVersion', JSON.stringify(prodVersion));
        } else if (sessionStorage.getItem('prodVersion') !== null) {
          this.prodVersion = JSON.parse(sessionStorage.getItem('prodVersion'));
          this.devVersion = JSON.parse(sessionStorage.getItem('devVersion'));
        }
      },

      _processSciGraphVersion(sciGraphResponse) {
        let version;
        for (const edge of sciGraphResponse.data.edges) {
          if (edge.pred === 'dcat:distribution') {
            if (edge.sub.endsWith('#ncbigene')) {
              version = edge.sub
                .replace('MonarchArchive:', 'https://archive.monarchinitiative.org/')
                .replace('/#ncbigene', '');
              break;
            }
          }
        }
        return version;
      },

      async fetchSciGraphVersion() {
        const sciGraphProd = 'https://scigraph-data.monarchinitiative.org/scigraph/dynamic/datasets.json';
        const sciGraphDev = 'https://scigraph-data-dev.monarchinitiative.org/scigraph/dynamic/datasets.json';

        let [devResponse, prodResponse] = await Promise.all(
          [
            this.getSciGraphData(sciGraphDev),
            this.getSciGraphData(sciGraphProd)
          ]
        );

        return [
          this._processSciGraphVersion(devResponse),
          this._processSciGraphVersion(prodResponse)
        ];
      },

      async updateSolrData(value, qualifier, associations, plotDiv){
        this.setSpinner(plotDiv, false);

        const solrData = await this.getSolrPivot(qualifier);
        this.makeHeatMap(solrData, associations, plotDiv, value);
        this.setSpinner(plotDiv, true);
      },

      makeHeatMap(solrData, association, plotDiv, selected = 'percent') {

        const sources = Object.keys(solrData.solrDev.gene_phenotype);
        let counts;
        let text = [];

        // Get counts from dev
        const devCounts = this.getCountsFromSolr(solrData.solrDev, association);
        const prodCounts = this.getCountsFromSolr(solrData.solrProd, association);

        const percentCounts = devCounts.map((assoc, yIndex) => {
          return assoc.map((source, xIndex) => {
            let percentageChange;

            const prodCount = prodCounts[yIndex][xIndex];

            if (source === 0 && prodCount !== 0) {
              percentageChange = -100;
            } else if (source === 0 && prodCount === 0) {
              percentageChange = 0;
            } else if (source !== 0 && prodCount === 0) {
              // If the association had 0 counts on production
              // fake a value since we can't div by 0
              percentageChange = source * 100;
            } else {
              percentageChange = ((source - prodCount) / prodCount) * 100;
            }
            return percentageChange
          });
        });
        for (const [assocIndex, assoc] of association.entries()) {
          const associationText = [];
          for (const [srcIndex, source] of sources.entries()) {
            associationText.push(
              `Source: ${source}<br>` +
              `Association: ${assoc}<br>` +
              `Percent change: ${percentCounts[assocIndex][srcIndex]
                .toFixed(2)
                .toLocaleString()}%<br>` +
              `Beta count: ${devCounts[assocIndex][srcIndex].toLocaleString()}<br>` +
              `Production count: ${prodCounts[assocIndex][srcIndex].toLocaleString()}<br>`
            );
          }
          text.push(associationText);
        }
        if (selected === 'percent') {
          counts = percentCounts;
        } else if (selected === 'dev') {
          counts = devCounts;
        } else if (selected === 'production') {
          counts = prodCounts;
        }

        const layout = {
          autosize: false,
          margin: {l:155, r:0, t:80, b:80},
          height: 23 * association.length + 160,
          width: 920,
          xaxis: {
             // title: 'Source'
            tickangle: 45,
            tickfont: {
              size: 13.5
            }
          },
          yaxis: {
            // title: 'Association'
            tickfont: {
              size: 13
            },
            showgrid: false
          },
        };

        const data = [
          {
            z: counts,
            x: sources,
            y: association,
            type: 'heatmap',
            hoverongaps: false,
            hoverinfo: 'text',
            text: text,
            xgap: 3,
            ygap: 3
          }
        ];

        if (selected === 'percent') {
          data[0].zmin = -100;
          data[0].zmax = 100;
          // https://plotly.com/javascript/colorscales/#custom-colorscale
          data[0].colorscale = [
            ['0.0', 'rgb(165,0,38)'],
            ['0.49', 'rgb(215,48,39)'],
            //['0.49', 'rgb(116,173,209)'],
            //['0.3', 'rgb(171,217,233)'],
            //['0.4', 'rgb(224,243,248)'],
            ['0.5', 'rgb(255,255,255)'],
            //['0.6', 'rgb(254,224,144)'],
            //['0.7', 'rgb(253,174,97)'],
            //['0.51', 'rgb(244,109,67)'],
            ['0.51', 'rgb(69,117,180)'],
            ['1.0', 'rgb(49,54,149)']
          ];
        } else {
          data[0].colorscale = [
            ['0', 'rgb(255,255,255)'],
            //['0.2', 'rgb(254,224,144)'],
            //['0.4', 'rgb(253,174,97)'],
            ['0.0001', 'rgb(116,173,209)'],
            ['0.5', 'rgb(69,117,180)'],
            ['1.0', 'rgb(49,54,149)']
          ];
        }

        Plotly.newPlot(plotDiv, data, layout);

      },
      processSource(source) {
        return path.basename(source)
          .replace('#', '')
          .replace('.ttl', '')
          .replace('.nt', '');
      },
      getCountsFromSolr(solrData, association) {
        const counts = [];
        const sources = Object.keys(solrData.gene_phenotype);

        for (const assoc of association) {
          const assocCount = [];
          for (const source of sources) {
            assocCount.push(solrData[assoc][source]);
          }
          counts.push(assocCount);
        }

        return counts;
      },
      async getSolrPivot(qualifier = 'all') {
        let solrData;
        const sessionStorage = window.sessionStorage;
        if (qualifier === 'all') {
          if (this.solrData === null && sessionStorage.getItem('solrData') === null) {
            solrData = await this.fetchSolrPivot('all');
            this.solrData = solrData;
            sessionStorage.setItem('solrData', JSON.stringify(solrData));
          } else if (sessionStorage.getItem('solrData') !== null) {
            this.solrData = JSON.parse(sessionStorage.getItem('solrData'));
            solrData = this.solrData;
          } else {
            solrData = this.solrData;
          }
        } else if (qualifier === 'direct') {
          if (this.solrDataDirect === null && sessionStorage.getItem('solrDataDirect') === null) {
            solrData = await this.fetchSolrPivot('direct');
            this.solrDataDirect = solrData;
            sessionStorage.setItem('solrDataDirect', JSON.stringify(solrData));
          } else if (!sessionStorage.getItem('solrDataDirect') !== null) {
            this.solrDataDirect = JSON.parse(sessionStorage.getItem('solrDataDirect'));
            solrData = this.solrDataDirect;
          } else {
            solrData = this.solrDataDirect;
          }
        }
        return solrData;
      },
      async fetchSolrPivot(qualifier) {
        const solrData = {
          'solrDev': {},
          'solrProd': {}
        };
        const solrProd = 'https://solr.monarchinitiative.org/solr/golr/select/';
        const solrDev = 'https://solr-dev.monarchinitiative.org/solr/golr/select/';
        const params = {
          'wt': 'json',
          'facet': true,
          'json.nl': 'arrarr',
          'rows': 0,
          'q': '*:*',
          // facet.pivot.mincount=0 included because kegg has no direct associations
          // which is a integration bug, this could be removed when that is fixed
          // for a slight speed up
          'facet.pivot.mincount': 0,
          'facet.pivot': 'association_type,is_defined_by',
          'facet.limit': '500'
        };
        if (qualifier === 'direct') {
          params.fq = "qualifier:direct";
        }
        const pivotTables = {
          'solrDev': {},
          'solrProd': {}
        };

        let [devSolrResp, prodSolrResp] = await Promise.all(
          [this.getSolrData(solrDev, params), this.getSolrData(solrProd, params)]);

        pivotTables.solrDev = devSolrResp.data.facet_counts.facet_pivot['association_type,is_defined_by'];
        pivotTables.solrProd = prodSolrResp.data.facet_counts.facet_pivot['association_type,is_defined_by'];

        let devSources = pivotTables.solrDev.flatMap(pivotTable =>
            pivotTable.pivot.map(source => this.processSource(source.value))
        );

        let prodSources = pivotTables.solrProd.flatMap(pivotTable =>
            pivotTable.pivot.map(source => this.processSource(source.value))
        );

        // In case theres a new source (or source removed)
        const allSources = Array.from(new Set(devSources.concat(prodSources))).sort();
        const allAssociations = this.phenotypeAssociations
          .concat(this.diseaseAssociations)
          .concat(this.otherAssociations)
          .concat(this.publicationAssociations);

        for (const association of allAssociations) {
          solrData.solrDev[association] = {};
          solrData.solrProd[association] = {};

          for (const source of allSources) {
            solrData.solrDev[association][source] = 0;
            solrData.solrProd[association][source] = 0;
          }
        }

        for (const solrType in pivotTables){
          for (const pivotTable of pivotTables[solrType]) {
            const association = pivotTable.value;
            for (const pivot of pivotTable.pivot) {
              const source = this.processSource(pivot.value);
              solrData[solrType][association][source] = pivot.count;
            }
          }
        }

        return solrData;
      },
      async getSolrData(solr, params) {
        return axios.get(solr, {
          params: params
        })
      },
      async getSciGraphData(scigraph) {
        return axios.get(scigraph);
      },
      setSpinner(plotDiv, bool) {
        // this is so awful
        if (plotDiv.startsWith('phenotype')) {
          this.phenotypesFetched = bool;
        } else if (plotDiv.startsWith('disease')) {
          this.diseasesFetched = bool;
        } else if (plotDiv.startsWith('publication')) {
          this.publicationsFetched = bool;
        } else if (plotDiv.startsWith('other')) {
          this.otherFetched = bool;
        }
      },
    }
  }
</script>

<style lang="css">

  .overview-spinner {
    margin: 0 auto;
    width: 0;
  }

  .chart-title {
    text-align: center;
    font-weight: bold;
    font-size: 20px;
    padding-bottom: 1em;
  }

  .theme-default-content .form-group {
    margin-bottom: .5em;
  }

  .chart {
    padding-bottom: 1em;
  }

  .scigraph-version {
    padding-bottom: 1em;
  }

</style>
