module.exports = function(app) {

  app.get('/health', (req, res) => {
    return res.json({
      output: {
        text: 'Seems to be OK'
      }
    });
  });
};
