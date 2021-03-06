module.exports = function(DaoCloud) {
  DaoCloud.greet = function(cb) {
    cb(null, 'Greetings DaoCloud');
  }

  DaoCloud.remoteMethod(
    'greet',
    {
      accepts: {arg: 'msg', type: 'string'},
      returns: {arg: 'greeting', type: 'string'}
    }
  );
};
