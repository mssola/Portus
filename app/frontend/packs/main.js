// Bootstrap
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/transition';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/tab';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/tooltip';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/popover';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/dropdown';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/button';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/collapse';

// Life it up
import '@portus-vendor/javascripts/lifeitup_layout';

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

import '@portus/globals/bootstrap';
import '@portus/globals/globals';

import '../stylesheets/application.scss';

require.context('../images', true);
