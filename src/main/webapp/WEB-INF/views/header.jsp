<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-inverse navbar-fixed-top" style="border: none; box-shadow: 0 2px 10px rgba(0,0,0,0.2);">
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="<%= request.getContextPath() %>/index.jsp" style="font-weight: 600;">🐴 EQUIDA</a>
    </div>
    <div id="navbar" class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Ventes <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="<%= request.getContextPath() %>/vente-servlet/list">Lister les ventes</a></li>
            <li><a href="<%= request.getContextPath() %>/vente-servlet/add">Ajouter une vente</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Chevaux <span class="caret"></span></a>
          <ul class="dropdown-menu">
        <li><a href="<%= request.getContextPath() %>/cheval-servlet/list">Lister les chevaux</a></li>
        <li><a href="<%= request.getContextPath() %>/cheval-servlet/add">Ajouter un cheval</a></li>
        </ul>
        </li>
      </ul>
          
    </div>
  </div>
</nav>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>