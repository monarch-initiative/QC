<template>
  <div>

    <D3Graphviz
      :graphviz-options="graphVizOptions"
    ></D3Graphviz>

  </div>

</template>

<script>
  import D3Graphviz from "./D3Graphviz";

  export default {
    components: {
      D3Graphviz,
    },
    props: {
      directory: {
        type: String,
        required: false,
        default: 'biolink'
      }
    },
    data() {
      return {}
    },
    computed: {
      graphVizOptions: function() {
        const graphvizOptions = require.context(
          '../public/gv/',
          true,
          /^.*\.gv$/
        )
          .keys()
          .filter (file => file.startsWith('./' + this.directory))
          .map((file) => {
              return {
                value: file,
                text: file.slice(2, -3).replace(this.directory + '/', '')
              }
          });
        graphvizOptions.push({
          value: null,
          text: 'Select a file'
        });
        return graphvizOptions;
      }
    }
  }


</script>
