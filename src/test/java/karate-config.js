function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    baseUrl: 'https://myfonts-development-base.myshopify.com/admin/api/2021-01/',
    accessToken: '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'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }

  karate.configure('headers', {'X-Shopify-Access-Token': config.accessToken})

  return config;
}