module.exports = {
  transpileDependencies: true,
  devServer: {
    port: 8082,
    historyApiFallback: true,
    client: {
      overlay: {
        runtimeErrors: false
      }
    },
    proxy: {
      '/admin': {
        target: 'http://localhost:8081',
        changeOrigin: true
      }
    }
  }
}
