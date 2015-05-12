var coffeeCoverage = require('coffee-coverage');
var coverageVar = coffeeCoverage.findIstanbulVariable();
var writeOnExit = coverageVar == null ? true : null;

coffeeCoverage.register({
    instrumentor: 'istanbul',
    basePath: process.cwd(),
    exclude: ['/test', '/node_modules', '/.git', '/gulpfile.coffee'],
    coverageVar: coverageVar,
    writeOnExit: writeOnExit ? ((_ref = process.env.COFFEECOV_OUT) != null ? _ref : 'coverage/coverage-coffee.json') : null,
    initAll: (_ref = process.env.COFFEECOV_INIT_ALL) != null ? (_ref === 'true') : true
});
