// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/transition';
// eslint-disable-next-line import/no-extraneous-dependencies
import '@bootstrapjs/collapse';

// Life it up.
import '@portus-vendor/javascripts/lifeitup_layout';

// Global stuff.
import '@portus/plugins';

// Modules
import '@portus/modules/admin/registries';

import '@portus/globals/bootstrap';
import '@portus/globals/globals';

// Import the stylesheets so webpack can track them.
import '../stylesheets/admin-registries.scss';

require.context('../images', true);
