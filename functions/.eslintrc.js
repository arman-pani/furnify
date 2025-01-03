module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2018,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "no-restricted-globals": ["error", "name", "length"],
    "prefer-arrow-callback": "error",
    "quotes": ["error", "double", { "allowTemplateLiterals": true }],
    "new-cap": "off", // Disable the 'new-cap' rule
    "camelcase": "off", // Disable the 'camelcase' rule
    "indent": ["error", 2], // Ensure 2 spaces for indentation
    "quote-props": ["error", "consistent"], // Fix inconsistent property quotes
    "comma-dangle": ["error", "always-multiline"], // Ensure consistent commas
    "object-curly-spacing": ["error", "always"], // Space inside curly braces
  },
  overrides: [
    {
      files: ["**/*.spec.*"],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};
