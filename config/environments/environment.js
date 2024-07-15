const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide', 
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQurey: 'jquery/src/jquery'
  })
)

module.exports = environment
