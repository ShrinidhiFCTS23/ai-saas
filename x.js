fetch("https://treebo-cp.console.facets.cloud/tunnel/627b96718b1e3b0001135990/grafana/api/datasources/proxy/1/api/v1/query_range?query=sum(kube_node_status_capacity_cpu_cores)&start=1653676200&end=1656268200&step=86400", {
  "headers": {
    "accept": "application/json, text/plain, */*",
    "accept-language": "en-GB,en-US;q=0.9,en;q=0.8",
    "sec-ch-ua": "\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"102\", \"Google Chrome\";v=\"102\"",
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "\"macOS\"",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "same-origin",
    "x-dashboard-id": "0",
    "x-grafana-org-id": "1",
    "x-panel-id": "Q-1656332890642-0.6248992863325187-0"
  },
  "referrer": "https://treebo-cp.console.facets.cloud/tunnel/627b96718b1e3b0001135990/grafana/explore?orgId=1&left=%5B%22now-30d%22,%22now%22,%22Prometheus%22,%7B%22expr%22:%22sum(kube_node_status_capacity_cpu_cores)%22,%22interval%22:%221d%22%7D,%7B%22mode%22:%22Metrics%22%7D,%7B%22ui%22:%5Btrue,true,true,%22none%22%5D%7D%5D",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": null,
  "method": "GET",
  "mode": "cors",
  "credentials": "include"
}).then(q=>{

})