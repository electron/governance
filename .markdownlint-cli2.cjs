const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

module.exports = {
  config: {
    extends: '@electron/lint-roller/configs/markdownlint.json',
  },
  customRules: [
    './node_modules/@electron/lint-roller/markdownlint-rules/index.mjs',
  ],
  ignores: fs.readFileSync(path.resolve(__dirname, '.markdownlintignore'), 'utf-8').trim().split(os.EOL),
};
