const { environment } = require('@rails/webpacker')

module.exports = environment


const webpack = require("webpack")
environment.plugins.append("provide",newwebpack.providedplugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js','default']
}))

