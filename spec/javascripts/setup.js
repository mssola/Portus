require('jsdom-global')(undefined, {
  url: "http://localhost",
});

const dayjs = require('dayjs');
const relativeTime = require('dayjs/plugin/relativeTime');

global.expect = require('expect');

dayjs.extend(relativeTime);
