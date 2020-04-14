// TODO: this whole file is a complete hack. We should instead let the
// stylesheet to pick the needed images by itself. That being said, doing that
// requires the modularization of stylesheets, which is a rather daunting task
// at the moment.

import '../stylesheets/errors.scss';

require.context('../images', true);
