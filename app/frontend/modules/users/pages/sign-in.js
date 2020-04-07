import BaseComponent from '@portus/base/component';

import { fadeIn } from '@portus/utils/effects';

// UsersSignInPage component responsible to instantiate
// the user's sign in page components and handle interactions.
class UsersSignInPage extends BaseComponent {
  mount() {
    fadeIn(this.$el.find('> .container-fluid'));
  }
}

export default UsersSignInPage;
