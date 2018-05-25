export function getServer(port) {
  let url = window.location.host;
  let server = '';
  if (url == "localhost:8080") {
    server = 'http://127.0.0.1/Graduation/Server/';
  }
  else {
    server = './Server/';
  }
  return server;
}
