import Vue from 'vue';

import TeamsIndexPage from './pages/index';
import TeamsShowPage from './pages/show';

$(() => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '.vue-root',

    components: {
      TeamsIndexPage,
      TeamsShowPage,
    },
  });
});
