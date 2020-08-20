const { description } = require('../../package');

module.exports = {
  /**
   * Ref：https://v1.vuepress.vuejs.org/config/#title
   */
  title: 'QC Dashboard',
  /**
   * Ref：https://v1.vuepress.vuejs.org/config/#description
   */
  description: description,

  /**
   * Extra tags to be injected to the page HTML `<head>`
   *
   * ref：https://v1.vuepress.vuejs.org/config/#head
   */
  head: [
    ['meta', { name: 'theme-color', content: '#3eaf7c' }],
    ['meta', { name: 'apple-mobile-web-app-capable', content: 'yes' }],
    ['meta', { name: 'apple-mobile-web-app-status-bar-style', content: 'black' }]
  ],

  base: '/',  // https://vuepress.vuejs.org/guide/deploy.html#github-pages

  /**
   * Theme configuration, here is the default theme configuration for VuePress.
   *
   * ref：https://v1.vuepress.vuejs.org/theme/default-theme-config.html
   */
  themeConfig: {
    repo: '',
    logo: '/img/monarch-logo-white.svg',
    editLinks: false,
    docsDir: '',
    editLinkText: '',
    lastUpdated: false,
    nav: [
      {
        text: 'Dipper',
        link: '/dipper/',
      },
      {
        text: 'SciGraph',
        link: '/scigraph/'
      },
      {
        text: 'Solr',
        link: '/solr/'
      },
      {
        text: 'Rules',
        link: '/rules/'
      },
      {
        text: 'Ontology',
        link: '/ontology/'
      },
      {
        text: 'Biolink Model',
        link: '/biolink/'
      },
      {
        text: 'About',
        link: '/about/'
      }
    ],
    sidebar: {
      '/dipper/': [
        {
          title: 'Dipper',
          collapsable: false,
          children: [
            ['', 'Introduction'],
            'namespace-table',
            'namespace-change',
            'namespace-reduced',
            'namespace-release'
          ]
        }
      ],
      '/biolink/': [
        {
          title: 'Biolink Model',
          collapsable: false,
          children: [
            ['', 'Introduction'],
            'schema'
          ]
        }
      ],
      '/solr/': [
        {
          title: 'Solr',
          collapsable: false,
          sidebarDepth: 2,
          children: [
            ['', 'About'],
            ['solr-diff.md', 'Solr Report']
          ]
        }
      ],
      '/rules/': [
        {
          title: 'Rules',
          collapsable: false,
          sidebarDepth: 2,
          children: [
            ['', 'About'],
            ['monarch-rules.md', 'Report']
          ]
        }
      ],
    }
  },

  /**
   * Apply plugins，ref：https://vuepress.vuejs.org/plugin
   */
  plugins: [
    '@vuepress/plugin-back-to-top',
    '@vuepress/plugin-medium-zoom',
  ],
  markdown: {
    lineNumbers: true,
    extendMarkdown: md => {
      md.use(require('markdown-it-include'), 'docs/.vuepress/public/md/');
    },
    extractHeaders: [ 'h2', 'h3', 'h4' ]
  }
};
