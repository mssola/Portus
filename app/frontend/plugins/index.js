import Vue from 'vue';
import VueResource from 'vue-resource';
import Vuelidate from 'vuelidate';

import EventBus from '@portus/plugins/eventbus';
import Alert from '@portus/plugins/alert';
import Config from '@portus/plugins/config';

import CSRF from '@portus/utils/csrf';

import configObj from '@portus/globals/config';

/*
 * Setup the configuration object. This used to be handled through another
 * script tag, but the move to webpacker broke this setup (probably for good
 * reasons). Now the strategy is different: we store a JSON object when
 * rendering the page, and then the Javascript code will parse this object,
 * setting this global variable. This should be safe since we are not storing
 * sensitive data (just configuration options for pagination and stuff like
 * that).
 */
try {
  const blob = document.getElementById('#portus-client-config').text.trim();
  const config = JSON.parse(atob(blob));

  configObj.apiUrl = config.apiUrl;
  configObj.pagination = config.pagination;
} catch (error) {
  // If things could not be taken from the JSON blob, let's take some defaults.
  configObj.apiUrl = '//' + window.location.hostname;
  configObj.pagination = { perPage: 10, beforeAfter: 2 };
}

Vue.use(Vuelidate);
Vue.use(VueResource);
Vue.use(EventBus);
Vue.use(Alert);
Vue.use(Config);

Vue.http.options.root = configObj.apiUrl;

Vue.http.interceptors.push((_request) => {
  window.$.active = window.$.active || 0;
  window.$.active += 1;

  return function () {
    window.$.active -= 1;
  };
});

Vue.http.interceptors.push((request) => {
  const token = CSRF.token();

  if (token !== null) {
    request.headers.set('X-CSRF-Token', token);
  }
});
