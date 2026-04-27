<%-- 
    Document   : list
    Created on : 8 avr. 2026, 09:39:42
    Author     : sio2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Lot" %>
<%@ page import="model.Enchere" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="card mt-4">
    <div class="card-body">
        <h5 class="card-title">Placer une enchère</h5>
        <%
        // On récupère l'objet "pLeLot" envoyé par le Servlet et on le stocke dans leLot
        Lot leLot = (Lot) request.getAttribute("pLeLot");
        %>
        <%-- Message d'erreur si la mise est trop basse --%>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger">Mise trop basse ! Tu dois proposer plus que le prix actuel.</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/enchere-servlet/ajouter" method="POST">
            <input type="hidden" name="idLot" value="<%= leLot.getId() %>">
            <div class="input-group mb-3">
                <span class="input-group-text">€</span>
                <input type="number" name="montant" class="form-control" placeholder="Ton prix..." required>
                <button class="btn btn-primary" type="submit">Enchérir !</button>
            </div>
        </form>
    </div>
</div>
    </body>
</html>
