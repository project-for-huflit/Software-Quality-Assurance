module.exports = {
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: 'tsconfig.json',
    tsconfigRootDir: __dirname,
    sourceType: 'module',
  },
  plugins: [
    '@typescript-eslint/eslint-plugin',
    'simple-import-sort'
  ],
  extends: [
    'plugin:@typescript-eslint/recommended',
    'plugin:prettier/recommended',
  ],
  root: true,
  env: {
    node: true,
    jest: true,
  },
  ignorePatterns: [
    '.eslintrc.js',
    '/dist/**/*'
  ],
  rules: {
    '@typescript-eslint/interface-name-prefix': 'off',
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    '@typescript-eslint/no-explicit-any': 'off',
    "linebreak-style": "off",
    
    quotes: ['error', 'single'],
    'import/no-unresolved': 0,
    'object-curly-spacing': ['error', 'always'],
    'no-unused-vars': 'off',
    '@typescript-eslint/no-unused-vars': 'error',
    'require-jsdoc': 0,
    'padding-line-between-statements': [
      'error',
      { blankLine: "always", prev: "*", next: "return" },
      { blankLine: "always", prev: "*", next: "if" },
      { blankLine: "always", prev: "*", next: "try" },
    ],
    'simple-import-sort/imports': 'error',
    'simple-import-sort/exports': 'error',
    "prettier/prettier": [
    "error",
      {
        "endOfLine": "auto"
      }
    ]
  },
};
