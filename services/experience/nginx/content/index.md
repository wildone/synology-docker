---
layout: page
title: Synology Docker Services
---

<!-- markdownlint-disable MD025 -->
# {{ page.title }}

<!-- markdownlint-disable MD033 -->
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Service</th>
      <th scope="col">Description</th>
      <th scope="col">URLs</th>
      <th scope="col">Port, Debug</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row"><img src="logos/nginx_icon.svg" alt="nginx" class="logo"></th>
      <td>Dashboard</td>
      <td>this page</td>
      <td><a target="_blank" class="btn btn-primary" href="{{ site.env.DOMAIN_URL }}">Open</a></td>
      <td>5080, 5443</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/PHP-logo.svg" alt="browse" class="logo"></th>
      <td>Proxy Browser</td>
      <td>browse web using OpenVPN proxy</td>
      <td><a target="_blank" class="btn btn-primary" href="{{ site.env.PROXY_BROWSER_URL }}">Open</a></td>
      <td>5182</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/postgres.svg" alt="Postgres Admin" class="logo"></th>
      <td>Postgres Admin</td>
      <td>admin your postgres instance</td>
      <td><a target="_blank" class="btn btn-primary" href="{{ site.env.POSTGRES_DB_ADMIN_URL }}">Browse</a></td>
      <td>5780</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/Transmission_Icon.svg" alt="transmission" class="logo"></th>
      <td>Transmission</td>
      <td>torrent client</td>
      <td><a target="_blank" class="btn btn-primary" href="{{ site.env.TRANSMISSION_URL }}">Open</a></td>
      <td>5191</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/Traefik.logo.png" alt="traefik" class="logo"></th>
      <td>Traefik Dashboard</td>
      <td>dashboard</td>
      <td><a target="_blank" class="btn btn-primary" href="{{ site.env.TRAEFIK_URL }}/dashboard/">Open</a>
      </td>
      <td>5880</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/privoxy.png" alt="privoxy" class="logo"></th>
      <td>Privoxy</td>
      <td>proxy to tunnel though same OpenVPN</td>
      <td>
        <a target="_blank" class="btn btn-primary" href="{{ site.env.PROXY_BROWSER_URL }}">Browse</a>
      </td>
      <td>5181</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/keycloak_icon_64px.svg" alt="keycloak" class="logo"></th>
      <td>Keycloak</td>
      <td>local auth to protect your services</td>
      <td><a target="_blank" class="btn btn-primary" href="{{ site.env.KEYCLOAK_URL }}">Open</a>
        <a target="_blank" class="btn btn-secondary" href="{{ site.env.KEYCLOAK_URL_ADMIN }}">Admin Console</a>
        <a target="_blank" class="btn btn-secondary" href="{{ site.env.KEYCLOAK_URL_ADMIN }}/management">HTTP Api</a></td>
      <td>5680, 5690</td>
    </tr>
    <tr>
      <th scope="row"><img src="logos/github-dark.png" alt="github"  class="logo"></th>
      <td>Github</td>
      <td>repo</td>
      <td>
          <a target="_blank" class="btn btn-primary" href="{{ site.env.GIT_REPO }}"><i class="fab fa-github"></i> Github</a>
      </td>
      <td></td>
    </tr>
  </tbody>
</table>
