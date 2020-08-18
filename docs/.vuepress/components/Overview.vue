<template>
  <div>

    <div class="chart-title">Phenotype Associations</div>

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

    <div class="chart-title">Disease Associations</div>

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

    <div class="chart-title">Publication Associations</div>

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

    <div class="chart-title">Other Associations</div>

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

      const solrData = await this.getSolrData();

      this.makeHeatMap(solrData, this.phenotypeAssociations, 'phenotype-heatmap');
      this.phenotypesFetched = true;

      this.makeHeatMap(solrData, this.diseaseAssociations, 'disease-heatmap');
      this.diseasesFetched = true;

      this.makeHeatMap(solrData, this.publicationAssociations, 'publication-heatmap');
      this.publicationsFetched = true;

      this.makeHeatMap(solrData, this.otherAssociations, 'other-heatmap');
      this.otherFetched = true;
    },
    methods: {

      async updateSolrData(value, qualifier, associations, plotDiv){
        this.setSpinner(plotDiv, false);

        const solrData = await this.getSolrData(qualifier);
        this.makeHeatMap(solrData, associations, plotDiv, value);
        this.setSpinner(plotDiv, true);

      },

      makeHeatMap(solrData, association, plotDiv, selected = 'percent') {

        const sources = Object.keys(solrData.solrDev.gene_phenotype);
        let counts;
        let text = [];

        //scale = 'auto';
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
              `Percent change: ${percentCounts[assocIndex][srcIndex].toFixed(2)}%<br>` +
              `Beta count: ${devCounts[assocIndex][srcIndex]}<br>` +
              `Production count: ${prodCounts[assocIndex][srcIndex]}<br>`
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
          margin: {l:140, r:0, t:80, b:80},
          height: 25 * association.length + 160,
          width: 900,
          xaxis: {
             // title: 'Source'
            tickangle: 45,
            size: 14
          },
          yaxis: {
            // title: 'Association'
            size: 14
          },
        };

        const data = [
          {
            z: counts,
            //z: [[1, null, 30, 50, 1], [20, 1, 60, 80, 30], [30, 60, 1, -10, 20]],
            x: sources,
            y: association,
            type: 'heatmap',
            hoverongaps: false,
            hoverinfo: 'text',
            text: text
          }
        ];

        if (selected === 'percent') {
          data[0].zmin = -100;
          data[0].zmax = 100;
          data[0].colorscale = [
            ['0.0', 'rgb(49,54,149)'],
            ['0.49', 'rgb(69,117,180)'],
            //['0.49', 'rgb(116,173,209)'],
            //['0.3', 'rgb(171,217,233)'],
            //['0.4', 'rgb(224,243,248)'],
            ['0.5', 'rgb(255,255,255)'],
            //['0.6', 'rgb(254,224,144)'],
            //['0.7', 'rgb(253,174,97)'],
            //['0.51', 'rgb(244,109,67)'],
            ['0.51', 'rgb(215,48,39)'],
            ['1.0', 'rgb(165,0,38)']
          ];
        } else {
          data[0].colorscale = [
            ['0', 'rgb(255,255,255)'],
            //['0.2', 'rgb(254,224,144)'],
            //['0.4', 'rgb(253,174,97)'],
            ['0.333333', 'rgb(244,109,67)'],
            ['0.666666', 'rgb(215,48,39)'],
            ['1.0', 'rgb(165,0,38)']
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
      async getSolrData(qualifier = 'all') {
        let solrData;
        if (qualifier === 'all') {
          if (this.solrData === null) {
            solrData = await this.fetchSolrData('all');
            this.solrData = solrData
          } else {
            solrData = this.solrData;
          }
        } else if (qualifier === 'direct') {
          if (this.solrDataDirect === null) {
            solrData = await this.fetchSolrData('direct');
            this.solrDataDirect = solrData;
          } else {
            solrData = this.solrDataDirect;
          }
        }
        return solrData;
      },
      async fetchSolrData(qualifier) {
        const solrData = {
          'solrDev': {},
          'solrProd': {}
        };
        const solrProd = 'https://solr.monarchinitiative.org/solr/golr/select/';
        const solrDev = 'https://solr-dev.monarchinitiative.org/solr/golr/select/';
        const solrs = [solrProd, solrDev];
        const params = {
          'wt': 'json',
          'facet': true,
          'json.nl': 'arrarr',
          'rows': 0,
          'q': '*:*',
          'facet.pivot': 'association_type,is_defined_by',
          'facet.limit': '500'
        };
        if (qualifier === 'direct') {
          params.fq = "qualifier:direct";
        }
        const pivotTables = {
          'solrProd': {},
          'solrDev': {}
        };

        for (const solr of solrs) {
          const solrResponse = await axios.get(solr, {
            params: params
          })
          .then(function (response) {
            return response.data
          })
          .catch(function (error) {
            //console.log(error);
          });
          if (solr.startsWith("https://solr-dev")) {
            pivotTables.solrDev = solrResponse.facet_counts.facet_pivot['association_type,is_defined_by'];
          } else {
            pivotTables.solrProd = solrResponse.facet_counts.facet_pivot['association_type,is_defined_by'];
          }
        }

        let devSources = new Set(
          pivotTables.solrDev.flatMap(pivotTable =>
            pivotTable.pivot.map(source => this.processSource(source.value))
          )
        );

        let prodSources = new Set(
          pivotTables.solrDev.flatMap(pivotTable =>
            pivotTable.pivot.map(source => this.processSource(source.value))
          )
        );

        devSources = Array.from(devSources).sort();
        prodSources = Array.from(prodSources).sort();

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
      }

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

</style>
