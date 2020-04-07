// Bootstrap
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/tooltip';

// Alert
import Vue from 'vue';
import Alert from '@portus/plugins/alert';

// Add some needed polyfills
import '@portus/globals/polyfill';

// Modules
import '@portus/modules/explore';
import '@portus/modules/users/unauthenticated';

import '@portus/globals/bootstrap';

Vue.use(Alert);

// Let webpack know about our images.
require.context('../images', true);
