<template>
  <div>

    <script src="https://unpkg.com/@hpcc-js/wasm/dist/index.min.js" type="javascript/worker" />

    <div>
      <b-form-select
        v-model="selected"
        v-on:change="renderGraphViz(selected)"
        :options="graphvizOptions">
      </b-form-select>
    </div>

    <div id="graph">
    </div>
  </div>

</template>

<script>
  import 'd3-graphviz';
  import * as d3 from 'd3';

  export default {
    components: {},
    props: {
      graphvizOptions: {
        type: Array,
        required: true,
      },
    },
    data() {
      return {
        selected: null
      }
    },
    methods: {
      async renderGraphViz(file) {
        const filePath = '/gv/' + file;
        let graphvizData = null;
        await fetch(filePath, {
          headers: {
            'Content-Type': 'text/vnd.graphviz; charset=UTF-8'
          },
        })
          .catch(error => {
            // console.log("error getting file");
          })
          .then(response => {
            return response.text()
              .then(text => {
                graphvizData = text;
              });
          });

        d3.select('#graph').graphviz()
          .renderDot(graphvizData);

      }
    }
  }


</script>
