// Bootstrap
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/transition';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/tab';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/tooltip';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/popover';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/dropdown';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/button';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrap/collapse';

// Life it up
import '@portus-vendor/lifeitup_layout';

// misc
import '@portus/plugins';
import '@portus/globals/polyfill';

// modules
import '@portus/modules/admin/registries';
import '@portus/modules/users';
import '@portus/modules/dashboard';
import '@portus/modules/repositories';
import '@portus/modules/namespaces';
import '@portus/modules/tags';
import '@portus/modules/teams';
import '@portus/modules/webhooks';

import '@portus/globals/globals';

// Let webpack know about our images.
require.context('../images', true);
