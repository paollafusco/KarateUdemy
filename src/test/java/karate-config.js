function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api'
  }
  if (env == 'dev') {
    config.userEmail = 'paolla1@test.com'
    config.userPassword = 'paolla1'
  } else if (env == 'qa') {
    config.userEmail = 'paolla2@test.com'
    config.userPassword = 'paolla2'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature',config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}