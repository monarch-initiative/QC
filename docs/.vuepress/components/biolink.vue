<template>

  <div>
    <b-dropdown id="dropdown-1" text="Dropdown Button" class="m-md-2">
      <b-dropdown-item>First Action</b-dropdown-item>
      <b-dropdown-item>Second Action</b-dropdown-item>
      <b-dropdown-item>Third Action</b-dropdown-item>
      <b-dropdown-divider></b-dropdown-divider>
      <b-dropdown-item active>Active action</b-dropdown-item>
      <b-dropdown-item disabled>Disabled action</b-dropdown-item>
    </b-dropdown>
  </div>

</template>

<script>
  // https://vuejs.org/v2/guide/single-file-components.html

  export default {
    //components: {},
    //props: {},
    data() {
      return {
        msg: 'The graphviz component will go here'
      }
    },
    //watch: {},
    //mounted: {},
    methods: {
      fetchGraphVizFiles() {

      }
    }
  }


</script>

<style lang="css">

</style>

