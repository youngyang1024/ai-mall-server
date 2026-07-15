module.exports = {
  transpileDependencies: true,
  devServer: {
    port: 9092,
    historyApiFallback: true,
    client: {
      overlay: {
        runtimeErrors: false
      }
    },
    proxy: {
      '/api': { target: 'http://localhost:9091', changeOrigin: true }
    }
  }
}
