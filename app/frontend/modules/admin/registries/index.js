import Vue from 'vue';

import AdminRegistriesNewPage from './pages/new';
import AdminRegistriesEditPage from './pages/edit';

$(() => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '.vue-root',

    components: {
      AdminRegistriesNewPage,
      AdminRegistriesEditPage,
    },
  });
});
