<template>
  <div>
    <script src="https://unpkg.com/@hpcc-js/wasm/dist/index.min.js" type="javascript/worker"/>

    <div class="file-select">
    <div class="select-dotfile">
      <b-form-select
        v-model="selected"
        v-on:change="renderGraphViz(selected, layout)"
        :options="graphvizOptions">
      </b-form-select>

      <b-form-select
        v-model="layout"
        v-on:change="renderGraphViz(selected, layout)"
        :options="layoutOptions">
      </b-form-select>



    </div>
      <div v-show="!graphRendered" class="graph-spinner">
        <b-spinner
          class="loading-spinner"
          type="grow"
          label="Loading"
        />
      </div>
    </div>

    <div id="graph">
    </div>
  </div>

</template>

<script>
  import 'd3-graphviz';
  import * as d3 from 'd3';
  import { wasmFolder } from "@hpcc-js/wasm";
  /* Not sure how to correctly import @hpcc-js/wasm
   * What seems to work:
   *
   * 1. Use a script tag: <script src="https://unpkg.com/@hpcc-js/wasm/dist/index.min.js"
   *                       type="javascript/worker" />
   *    (works but we still get a web console error)
   *
   * 2. Create public wasm dir and copy graphvizlib.wasm
   *    from node_modules/@hpcc-js/wasm/dist/graphvizlib.wasm
   *    with - wasmFolder('/wasm');
   *    (works and no web console error)
   *
   */

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
        selected: null,
        layout: null,
        graphRendered: true,
        layoutOptions: [
          {
            value: null,
            text: 'Select a layout'
          },
          {
            value: 'dot',
            text: 'dot (default)'
          },
          {
            value: 'circo',
            text: 'circo'
          },
          // fdp doesn't work well
          //{
          //  value: 'fdp',
          //  text: 'fdp'
          //},
          {
            value: 'neato',
            text: 'neato'
          },
          {
            value: 'osage',
            text: 'osage'
          },
          {
            value: 'patchwork',
            text: 'patchwork'
          },
          {
            value: 'twopi',
            text: 'twopi'
          }
        ]
      }
    },
    methods: {
      async renderGraphViz(file, layout) {
        this.graphRendered = false;
        wasmFolder('/wasm');
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

        if (layout === null) {
          layout = 'dot';
        }

        const transition = d3.transition()
          .duration(1000)
          .ease(d3.easeLinear);

        d3.select('#graph').graphviz()
          .transition(transition)
          .engine(layout)
          .renderDot(graphvizData);

        this.graphRendered = true;
      }
    }
  }


</script>


<style lang="css">

  .select-dotfile {
    width:30em;
    padding-bottom:1em;

  }
  .file-select {
    width: 100%;
    display: inline-flex;
  }
  .graph-spinner {
    padding: 1em 0 0 2em;
  }


</style>
