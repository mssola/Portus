import Alert from '@portus/utils/alert';

export default function install(Vue) {
  Object.defineProperties(Vue.prototype, {
    $alert: {
      get() {
        return Alert;
      },
    },
  });
}
