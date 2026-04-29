<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path = request.getContextPath(); %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="dropdown" data-target="#navbar-main">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="<%= path %>/index.jsp">🐴 EQUIDA</a>
    </div>

    <div id="navbar-main" class="collapse navbar-collapse">
      <ul class="nav navbar-nav">

        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
            Ventes <span class="caret"></span>
          </a>
          <ul class="dropdown-menu">
            <li><a href="<%= path %>/vente-servlet/list">Lister les ventes</a></li>
            <li><a href="<%= path %>/vente-servlet/add">Ajouter une vente</a></li>
          </ul>
        </li>

        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
            Chevaux <span class="caret"></span>
          </a>
          <ul class="dropdown-menu">
            <li><a href="<%= path %>/cheval-servlet/list">Lister les chevaux</a></li>
            <li><a href="<%= path %>/cheval-servlet/add">Ajouter un cheval</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
  /* Pour éviter que le haut de ta page soit caché par la nav-bar fixe */
  body { padding-top: 70px; }
  .dropdown:hover .dropdown-menu { display: block; } /* Optionnel : ouvre au survol en plus du clic */
</style>